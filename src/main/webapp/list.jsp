<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Student List</title>

    <style>
        body {
            font-family: "Segoe UI", Arial, sans-serif;
            background: #f4f6f9;
            padding: 30px;
        }

        .container {
            max-width: 1100px;
            margin: auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        h2 {
            margin-bottom: 15px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #007bff;
            color: white;
            padding: 10px;
        }

        td {
            border: 1px solid #ddd;
            padding: 6px;
            text-align: center;
        }

        button {
            padding: 6px 12px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            margin: 2px;
        }

        .edit {
            background: #ffc107;
        }

        .delete {
            background: #dc3545;
            color: white;
        }

        a {
            text-decoration: none;
            color: #007bff;
            display: inline-block;
            margin-bottom: 15px;
        }
    </style>
</head>

<body>

<div class="container">
    <a href="create.jsp">➕ Add Student</a>

    <h2>Student List</h2>

    <table>
        <thead>
            <tr>
                <th>ID</th><th>Name</th><th>Email</th>
                <th>Department</th><th>Age</th><th>Phone</th><th>Action</th>
            </tr>
        </thead>
        <tbody id="students"></tbody>
    </table>
</div>

<script>
const API = "students";

function loadStudents() {
    fetch(API)
    .then(res => res.json())
    .then(data => {
        const tbody = document.getElementById("students");
        tbody.innerHTML = "";

        data.forEach(s => {
            tbody.innerHTML += `
                <tr>
                    <td>${s.id}</td>
                    <td>${s.name}</td>
                    <td>${s.email}</td>
                    <td>${s.department}</td>
                    <td>${s.age}</td>
                    <td>${s.phone}</td>
                    <td>
                        <button class="edit" onclick="editStudent(${s.id})">Edit</button>
                        <button class="delete" onclick="deleteStudent(${s.id})">Delete</button>
                    </td>
                </tr>
            `;
        });
    });
}

function editStudent(id) {
    window.location.href = "create.jsp?id=" + id;
}

function deleteStudent(id) {
    if (confirm("Are you sure?")) {
        fetch(API + "?id=" + id, { method: "DELETE" })
            .then(loadStudents);
    }
}

loadStudents();
</script>

</body>
</html>
