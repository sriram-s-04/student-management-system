package com.iamneo.studentms.Controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.google.gson.Gson;
import com.iamneo.studentms.Dao.studentDao;
import com.iamneo.studentms.Model.studentModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/students")
public class studentController extends HttpServlet {

    private static final Gson gson = new Gson();
    public final studentDao studentDAO = new studentDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String id = req.getParameter("id");

        if (id == null) {
            try {
                List<studentModel> students = studentDAO.getStudents();
                resp.setStatus(200);
                resp.setContentType("application/json");
                resp.getWriter().write(gson.toJson(students));
            } catch (SQLException | ClassNotFoundException e) {
                resp.sendError(500, e.getMessage());
                e.printStackTrace();
            }
        } else {
            try {
                studentModel student = studentDAO.getStudentById(Integer.parseInt(id));
                resp.setStatus(200);
                resp.setContentType("application/json");
                resp.getWriter().write(gson.toJson(student));
            } catch (SQLException | ClassNotFoundException e) {
                resp.sendError(500, e.getMessage());
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        studentModel student = gson.fromJson(req.getReader(), studentModel.class);

        try {
            studentModel saved = studentDAO.addStudent(student);
            resp.setStatus(201);
            resp.setContentType("application/json");
            resp.getWriter().write(gson.toJson(saved));
        } catch (SQLException | ClassNotFoundException e) {
            resp.sendError(500, e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        studentModel inputStudent = gson.fromJson(req.getReader(), studentModel.class);

        try {
            studentModel updated = studentDAO.updateStudent(id, inputStudent);

            if (updated == null) {
                resp.setStatus(404);
                resp.setContentType("text/plain");
                resp.getWriter().write("Student with id " + id + " not found");
                return;
            }

            resp.setStatus(200);
            resp.setContentType("application/json");
            resp.getWriter().write(gson.toJson(updated));

        } catch (SQLException | ClassNotFoundException e) {
            resp.sendError(500, e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        try {
            boolean isDeleted = studentDAO.deleteStudent(id);
            resp.setContentType("text/plain");

            if (!isDeleted) {
                resp.setStatus(404);
                resp.getWriter().write("Student with id " + id + " not found");
                return;
            }

            resp.setStatus(200);
            resp.getWriter().write("Student deleted successfully");

        } catch (Exception e) {
            resp.sendError(500, e.getMessage());
            e.printStackTrace();
        }
    }
}
