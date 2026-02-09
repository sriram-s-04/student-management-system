<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Student Management</title>

    <style>
        body {
            font-family: "Segoe UI", Arial, sans-serif;
            background: #f4f6f9;
            margin: 0;
            padding: 30px;
        }

        .container {
            max-width: 1000px;
            margin: auto;
            background: #ffffff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        h2 {
            color: #333;
            margin-bottom: 10px;
        }

        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 10px;
            margin-bottom: 15px;
        }

        input {
            padding: 8px 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
            outline: none;
        }

        input:focus {
            border-color: #007bff;
        }

        button {
            padding: 8px 14px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            font-weight: 500;
        }

        .add-btn {
            background: #007bff;
            color: white;
        }

        .add-btn:hover {
            background: #0056b3;
        }

        .update-btn {
            background: #28a745;
            color: white;
        }

        .delete-btn {
            background: #dc3545;
            color: white;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
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

        tr:nth-child(even) {
            background: #f9f9f9;
        }

        tr:hover {
            background: #eef3ff;
        }

        td input {
            width: 100%;
            border: none;
            background: transparent;
            text-align: center;
        }

        hr {
            margin: 25px 0;
            border: none;
            height: 1px;
            background: #ddd;
        }
    </style>
</head>

<body>

<div class="container">

    <h2>Add Student</h2>

    <div class="form-row">
        <input id="name" placeholder="Name">
        <input id="email" placeholder="Email">
        <input id="dept" placeholder="Department">
        <input id="age" type="number" placeholder="Age">
        <input id="phone" placeholder="Phone">
    </div>

    <button class="add-btn" onclick="addStudent()">Add Student</button>

    <hr>

    <h2>Student List</h2>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Department</th>
                <th>Age</th>
                <th>Phone</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody id="students"></tbody>
    </table>

</div>

<script>
    const API = "students"; // backend servlet / controller mapping

    function addStudent() {
        const student = {
            name: document.getElementById("name").value.trim(),
            email: document.getElementById("email").value.trim(),
            department: document.getElementById("dept").value.trim(),
            age: parseInt(document.getElementById("age").value),
            phone: document.getElementById("phone").value.trim()
        };

        if (!student.name || !student.email) {
            alert("Name and Email are required");
            return;
        }

        fetch(API, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(student)
        })
        .then(res => res.json())
        .then(() => {
            loadStudents();
            clearForm();
        })
        .catch(err => alert("Error: " + err));
    }

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
                        <td><input id="n${s.id}" value="${s.name}"></td>
                        <td><input id="e${s.id}" value="${s.email}"></td>
                        <td><input id="d${s.id}" value="${s.department}"></td>
                        <td><input id="a${s.id}" type="number" value="${s.age}"></td>
                        <td><input id="p${s.id}" value="${s.phone}"></td>
                        <td>
                            <button class="update-btn" onclick="updateStudent(${s.id})">Update</button>
                            <button class="delete-btn" onclick="deleteStudent(${s.id})">Delete</button>
                        </td>
                    </tr>
                `;
            });
        });
    }

    function updateStudent(id) {
        const student = {
            name: document.getElementById("n" + id).value.trim(),
            email: document.getElementById("e" + id).value.trim(),
            department: document.getElementById("d" + id).value.trim(),
            age: parseInt(document.getElementById("a" + id).value),
            phone: document.getElementById("p" + id).value.trim()
        };

        fetch(API + "?id=" + id, {
            method: "PUT",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(student)
        }).then(loadStudents);
    }

    function deleteStudent(id) {
        fetch(API + "?id=" + id, {
            method: "DELETE"
        }).then(loadStudents);
    }

    function clearForm() {
        document.getElementById("name").value = "";
        document.getElementById("email").value = "";
        document.getElementById("dept").value = "";
        document.getElementById("age").value = "";
        document.getElementById("phone").value = "";
    }

    loadStudents();
</script>

</body>
</html>
