<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add / Update Student</title>

    <style>
        body {
            font-family: "Segoe UI", Arial, sans-serif;
            background: #f4f6f9;
            padding: 40px;
        }

        .card {
            max-width: 520px;
            margin: auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-bottom: 12px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        button {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: none;
            background: #007bff;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background: #0056b3;
        }

        .link {
            text-align: center;
            margin-top: 15px;
        }

        .link a {
            text-decoration: none;
            color: #007bff;
        }
    </style>
</head>

<body>

<div class="card">
    <h2 id="title">Add Student</h2>

    <input type="hidden" id="studentId">

    <input id="name" placeholder="Name">
    <input id="email" placeholder="Email">
    <input id="dept" placeholder="Department">
    <input id="age" type="number" placeholder="Age">
    <input id="phone" placeholder="Phone">

    <button onclick="saveStudent()">Save</button>

    <div class="link">
        <a href="list.jsp">View Student List</a>
    </div>
</div>

<!-- <script>
const API = "students";

// Check if edit mode
const params = new URLSearchParams(window.location.search);
const editId = params.get("id");

if (editId) {
    document.getElementById("title").innerText = "Update Student";

    fetch(API + "?id=" + editId)
    .then(res => res.json())
    .then(s => {
        studentId.value = s.id;
        name.value = s.name;
        email.value = s.email;
        dept.value = s.department;
        age.value = s.age;
        phone.value = s.phone;
    });
}

function saveStudent() {
    const id = studentId.value;

    const student = {
        name: name.value.trim(),
        email: email.value.trim(),
        department: dept.value.trim(),
        age: parseInt(age.value),
        phone: phone.value.trim()
    };

    if (!student.name || !student.email) {
        alert("Name and Email are required");
        return;
    }

    // UPDATE
    if (id) {
        fetch(API + "?id=" + id, {
            method: "PUT",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(student)
        }).then(() => {
            alert("Student updated successfully");
            window.location.href = "list.jsp";
        });
    }
    // CREATE
    else {
        fetch(API, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(student)
        }).then(() => {
            alert("Student added successfully");
            clearForm();
        });
    }
}

function clearForm() {
    ["studentId","name","email","dept","age","phone"]
        .forEach(id => document.getElementById(id).value = "");
}
</script> -->
<script>
const API = "students";

const params = new URLSearchParams(window.location.search);
const editId = params.get("id");

if (editId) {
    document.getElementById("title").innerText = "Update Student";

    fetch(API + "?id=" + editId)
    .then(res => res.json())
    .then(s => {
        document.getElementById("studentId").value = s.id;
        document.getElementById("name").value = s.name;
        document.getElementById("email").value = s.email;
        document.getElementById("dept").value = s.department;
        document.getElementById("age").value = s.age;
        document.getElementById("phone").value = s.phone;
    });
}

function saveStudent() {
    const id = document.getElementById("studentId").value;

    const student = {
        name: document.getElementById("name").value.trim(),
        email: document.getElementById("email").value.trim(),
        department: document.getElementById("dept").value.trim(),
        age: parseInt(document.getElementById("age").value),
        phone: document.getElementById("phone").value.trim()
    };

    if (!student.name || !student.email) return;

    const options = {
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(student)
    };

    // UPDATE
    if (id) {
        fetch(API + "?id=" + id, { ...options, method: "PUT" })
            .then(() => window.location.href = "list.jsp");
    }
    // CREATE
    else {
        fetch(API, { ...options, method: "POST" })
            .then(() => window.location.href = "list.jsp");
    }
}
</script>



</body>
</html>
