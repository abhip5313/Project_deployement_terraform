const apiUrl = "http://34.200.218.122:5000/api/students";

// Load students on page load
window.onload = getStudents;

function addStudent() {
  const student = {
    name: document.getElementById("name").value,
    email: document.getElementById("email").value,
    mobile: document.getElementById("mobile").value
  };

  fetch(apiUrl, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(student)
  })
  .then(() => {
    getStudents();
    clearForm();
  });
}

function getStudents() {
  fetch(apiUrl)
    .then(res => res.json())
    .then(data => {
      const table = document.getElementById("studentTable");
      table.innerHTML = `
        <tr>
          <th>ID</th>
          <th>Name</th>
          <th>Email</th>
          <th>Mobile</th>
          <th>Action</th>
        </tr>`;

      data.forEach(s => {
        table.innerHTML += `
          <tr>
            <td>${s.id}</td>
            <td>${s.name}</td>
            <td>${s.email}</td>
            <td>${s.mobile}</td>
            <td>
              <button onclick="deleteStudent(${s.id})">Delete</button>
            </td>
          </tr>`;
      });
    });
}

function deleteStudent(id) {
  fetch(`${apiUrl}/${id}`, {
    method: "DELETE"
  }).then(() => getStudents());
}

function clearForm() {
  document.getElementById("name").value = "";
  document.getElementById("email").value = "";
  document.getElementById("mobile").value = "";
}
