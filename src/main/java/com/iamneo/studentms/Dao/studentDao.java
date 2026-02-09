package com.iamneo.studentms.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.iamneo.studentms.Model.studentModel;
import com.iamneo.studentms.Util.studentUtil;

public class studentDao {

    // ADD STUDENT
    public studentModel addStudent(studentModel studentReq)
            throws SQLException, ClassNotFoundException {

        String sql = "INSERT INTO student (name, email, department, age, phone) VALUES (?, ?, ?, ?, ?)";

        try (
            Connection conn = studentUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)
        ) {
            pstmt.setString(1, studentReq.getName());
            pstmt.setString(2, studentReq.getEmail());
            pstmt.setString(3, studentReq.getDepartment());
            pstmt.setInt(4, studentReq.getAge());
            pstmt.setString(5, studentReq.getPhone());

            pstmt.executeUpdate();

            ResultSet rs = pstmt.getGeneratedKeys();
            if (!rs.next()) {
                throw new SQLException("Student ID not generated");
            }

            int id = rs.getInt(1);
            return getStudentById(id);
        }
    }

    // GET ALL STUDENTS
    public List<studentModel> getStudents()
            throws SQLException, ClassNotFoundException {

        String sql = "SELECT * FROM student";
        List<studentModel> students = new ArrayList<>();

        try (
            Connection conn = studentUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
        ) {
            while (rs.next()) {
                students.add(mapRowToStudent(rs));
            }
        }
        return students;
    }

    // GET STUDENT BY ID
    public studentModel getStudentById(int studentId)   
            throws SQLException, ClassNotFoundException {

        String sql = "SELECT * FROM student WHERE id = ?";

        try (
            Connection conn = studentUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setInt(1, studentId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return mapRowToStudent(rs);
            }
        }
        return null;
    }

    // UPDATE STUDENT
    public studentModel updateStudent(int studentId, studentModel studentReq)
            throws SQLException, ClassNotFoundException {

        String sql = "UPDATE student SET name = ?, email = ?, department = ?, age = ?, phone = ? WHERE id = ?";

        try (
            Connection conn = studentUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setString(1, studentReq.getName());
            pstmt.setString(2, studentReq.getEmail());
            pstmt.setString(3, studentReq.getDepartment());
            pstmt.setInt(4, studentReq.getAge());
            pstmt.setString(5, studentReq.getPhone());
            pstmt.setInt(6, studentId);

            pstmt.executeUpdate();
            return getStudentById(studentId);
        }
    }

    // DELETE STUDENT
    public boolean deleteStudent(int studentId) {

        String sql = "DELETE FROM student WHERE id = ?";

        try (
            Connection conn = studentUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setInt(1, studentId);
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // MAPPER METHOD
    private studentModel mapRowToStudent(ResultSet rs) throws SQLException {
        return new studentModel(
            rs.getInt("id"),
            rs.getString("name"),
            rs.getString("email"),
            rs.getString("department"),
            rs.getInt("age"),
            rs.getString("phone")
        );
    }
}
