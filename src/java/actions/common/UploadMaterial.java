/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package actions.common;

import actions.Action;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author quocb
 */
public class UploadMaterial implements Action {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try ( PrintWriter out = response.getWriter()) {
            try {
                Part filePart = request.getPart("file");
                InputStream fileContent = filePart.getInputStream();
                Path fileName = Paths.get(filePart.getSubmittedFileName());
                String uploadPath = request.getServletContext().getRealPath("/db").replace("\\build\\web", "") + File.separator;
                File uploadDir = new File(uploadPath);
                System.out.println("is ext" + uploadDir.exists());
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }
                byte[] buffer = new byte[4096];
                int bytesRead = -1;
                try ( OutputStream outputStream = new FileOutputStream(new File(uploadPath + File.separator + fileName))) {
                    while ((bytesRead = fileContent.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                    }
                }
//                filePart.write(uploadPath + File.separator + fileName);
                System.out.println("Name " + filePart.getName());
                System.out.println("Submited Name " + filePart.getSubmittedFileName());
                System.out.println("Size " + filePart.getSize());
                File tempFile = new File(filePart.getSubmittedFileName());
                if (tempFile.exists()) {
                    tempFile.delete();
                }
                
                
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

}
