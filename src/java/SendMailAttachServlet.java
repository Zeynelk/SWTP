
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
 
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
 
/**
 * A servlet that takes message details from user and send it as a new e-mail
 * through an SMTP server. The e-mail message may contain attachments which
 * are the files uploaded from client.
 *
 * @author www.codejava.net
 *
 */

@WebServlet("/user/SendMailAttachServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,   // 2MB
                maxFileSize = 1024 * 1024 * 10,         // 10MB
                maxRequestSize = 1024 * 1024 * 50)      // 50MB
public class SendMailAttachServlet extends HttpServlet {
    private String host;
    private String port;
    private String user;
    private String pass;
 
     
    // size of byte buffer to send file
    private static final int BUFFER_SIZE = 4096;   
     
    // database connection settings
    private String dbURL = "jdbc:mysql://localhost:3306/AppDB";
    private String dbUser = "root";
    private String dbPass = "";
    
    public void init() {
        // reads SMTP server setting from web.xml file
        ServletContext context = getServletContext();
        host = context.getInitParameter("host");
        port = context.getInitParameter("port");
        user = context.getInitParameter("user");
        pass = context.getInitParameter("pass");
    }
 
    /**
     * handles form submission
     */
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
         
        List<File> uploadedFiles = new ArrayList<File>();
 
     
     
        File x = new File("Hallo.jpg");
            String firstName = "Alim";
         
        Connection conn = null; // connection to the database
       try{
              // connects to the database
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
            
            // queries the database
            String sql = "SELECT * FROM contacts WHERE first_name = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, firstName);
             ResultSet result = statement.executeQuery();
               if (result.next()) {
                // gets file name and file blob data

                Blob blob = result.getBlob("photo");
                InputStream inputStream = blob.getBinaryStream();
                int fileLength = inputStream.available();
                 
                System.out.println("fileLength = " + fileLength);
 
 
 
                // writes the file to the client
                FileOutputStream outStream = new FileOutputStream(x);
                 
                byte[] buffer = new byte[BUFFER_SIZE];
                int bytesRead = -1;
                 
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outStream.write(buffer, 0, bytesRead);
                }
                 
                inputStream.close();
                outStream.close();             
            }
           
       
       }catch(SQLException ex){
          ex.printStackTrace();
       }
        
        uploadedFiles.add(x);
         
        String recipient = request.getParameter("recipient");
        String subject = request.getParameter("subject");
        String content = request.getParameter("content");
 
        String resultMessage = "";
 
        try {
            EmailUtility.sendEmailWithAttachment(host, port, user, pass,
                    recipient, subject, content, uploadedFiles);
             
            resultMessage = "The e-mail was sent successfully";
        } catch (Exception ex) {
            ex.printStackTrace();
            resultMessage = "There were an error: " + ex.getMessage();
        } finally {
            deleteUploadFiles(uploadedFiles);
            request.setAttribute("message", resultMessage);
            getServletContext().getRequestDispatcher("/result.jsp").forward(
                    request, response);
        }
    }
 
 
 
    /**
     * Retrieves file name of a upload part from its HTTP header
     */
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return null;
    }
     
    /**
     * Deletes all uploaded files, should be called after the e-mail was sent.
     */
    private void deleteUploadFiles(List<File> listFiles) {
        if (listFiles != null && listFiles.size() > 0) {
            for (File aFile : listFiles) {
                aFile.delete();
            }
        }
    }
}