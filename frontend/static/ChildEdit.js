if(!localStorage.getItem("prof_token")){
    window.location.href = "/login"; // To be added after testing
}

var url = (window.location.href.slice(window.location.href.indexOf('?') + 1).split('&'))[0];  
var student_id = url.split('=')[1]

$(document).ready(function(){
    $.ajax
    ({
        type: "GET",
        url: 'https://localhost:5001/professor/abcd',
        beforeSend: function (xhr) {
            xhr.setRequestHeader('Authorization', `Bearer ${localStorage.getItem("prof_token")}`);
        },
        success: function (data) {
            
            $("#subject-name").text(data.subject);
            $("#subject-name").attr("subject-name", data.subject)
        },
        error: function (XMLHttpRequest, textStatus, errorThrown){
            localStorage.removeItem("prof_token");
            window.location.href = "/login";
        }
    });

    $.ajax
    ({
        type: "GET",
        url: `https://localhost:5001/students/info/${student_id}`,
        beforeSend: function (xhr) {
            xhr.setRequestHeader('Authorization', `Bearer ${localStorage.getItem("prof_token")}`);
        },
        success: function (data) {
            $("#student-name").text(data.lastName + " " + data.firstName);
            appendData(data)
        },
        error: function (XMLHttpRequest, textStatus, errorThrown){
            localStorage.removeItem("prof_token");
            window.location.href = "/login";
        }
    })
});

function appendData(student){
    appendGrades(student.grades)
    appendAssignments(student.assignments)
    appendTardines(student.absences)
}

function appendGrades(grades){
    
    grades.forEach(grade => {
        let [month, date, year] = new Date(grade.date).toLocaleDateString("en-US").split("/")
        if(grade.subject == $("#subject-name").attr("subject-name")){
            $("#student-grades").append(
                `
                <tr>
                    <td>${grade.value}</td>
                    <td>${date}/${month}/${year}</td>
                    <td></td>
                 </tr>
                `
            )
        }
    });
    
    $("#student-grades").append(
        `
        <tr>
            <td><input type="number" id="grade-value" name="grade-value"></td>
            <td><input type="date" id="grade-date" name="grade-date"></td>
            <td><i id="add-grade" class="far fa-plus-square clickable"></i></td>
         </tr>
        `
    );

    $("#add-grade").click(function(){
        grade = {
            student: student_id,
            value: $("#grade-value").val(),
            date: new Date($("#grade-date").val() || new Date())
        }
        
        if(!(grade.value <= 10 && grade.value >= 1)){
            alert("Grade must be a valid number between 1 and 10");
        }else{
            $.ajax
            ({
                type: "POST",
                url: 'https://localhost:5001/students/grades',
                contentType: 'application/json',
                data: JSON.stringify(grade),
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', `Bearer ${localStorage.getItem("prof_token")}`);
                },
                success: function (data) {
                    location.reload();
                },
                error: function (xhr, textStatus, errorThrown){
                    if(xhr.status == 400){
                        alert("Something went wrong")
                    }else{
                        localStorage.removeItem("prof_token");
                        window.location.href = "/login";
                    }
                }
            })
        }
    });
}

function appendAssignments(assignments){
    assignments.forEach(assignment => {
        let [monthDue, dateDue, yearDue] = new Date(assignment.dateDue).toLocaleDateString("en-US").split("/");
        let [monthFrom, dateFrom, yearFrom] = new Date(assignment.dateFrom).toLocaleDateString("en-US").split("/");

        if(assignment.subject == $("#subject-name").attr("subject-name")){
            $("#student-assignments").append(
                `
                <tr>
                    <td>${dateFrom}/${monthFrom}/${yearFrom}</td>
                    <td id="${assignment.id}-due-date">${dateDue}/${monthDue}/${yearDue}</td>
                    <td><input type="checkbox" id="${assignment.id}-assignment-done" name="${assignment.id}-assignment-done" ${assignment.done ? "checked":""}></td>
                    <td></td>
                </tr>
                `
            )

            $(`#${assignment.id}-assignment-done`).change(function() {
                assignment_modified = {
                    done: this.checked,
                    dateDue: new Date($(`#${assignment.id}-due-date`).val() || new Date())
                }
        
                $.ajax
                ({
                    type: "PUT",
                    url: `https://localhost:5001/students/assignments/${assignment.id}`,
                    contentType: 'application/json',
                    data: JSON.stringify(assignment_modified),
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', `Bearer ${localStorage.getItem("prof_token")}`);
                    },
                    success: function (data) {
                        location.reload();
                    },
                    error: function (xhr, textStatus, errorThrown){
                        if(xhr.status == 400){
                            alert("Something went wrong")
                        }else{
                            console.log(xhr)
                            localStorage.removeItem("prof_token");
                            window.location.href = "/login";
                        }
                    }
                })
            });
        }
    });

    $("#student-assignments").append(
        `
            <td><input type="date" id="assignment-from-date" name="assignment-from-date"></td>
            <td><input type="date" id="assignment-due-date" name="assignment-due-date"></td>
            <td></td>
            <td><i id="add-assignment" class="far fa-plus-square clickable"></i></td>
        `
    );


    $("#add-assignment").click(function(){
        assignment = {
            student: student_id,
            dateFrom: new Date($("#assignment-from-date").val() || new Date()),
            dateDue: new Date($("#assignment-due-date").val() || new Date())
        }
        
        $.ajax
        ({
            type: "POST",
            url: 'https://localhost:5001/students/assignments',
            contentType: 'application/json',
            data: JSON.stringify(assignment),
            beforeSend: function (xhr) {
                xhr.setRequestHeader('Authorization', `Bearer ${localStorage.getItem("prof_token")}`);
            },
            success: function (data) {
                location.reload();
            },
            error: function (xhr, textStatus, errorThrown){
                if(xhr.status == 400){
                    alert("Something went wrong")
                }else{
                    console.log(xhr)
                    localStorage.removeItem("prof_token");
                    window.location.href = "/login";
                }
            }
        })
        
    });
}

function appendTardines(tardines){
    tardines.forEach(absence => {
        let [month, date, year] = new Date(absence.date).toLocaleDateString("en-US").split("/")
        if(absence.subject == $("#subject-name").attr("subject-name")){
            $("#student-absences").append(
                `
                <tr>
                    <td>${date}/${month}/${year}</td>
                    <td><input class="checkbox" type="checkbox" id="${absence.id}-absence-motivated" name="${absence.id}-absence-motivated" ${absence.excused ? "checked":""}></td>
                    <td><input type="text" id="${absence.id}-absence-motivation" value="${absence.motivation}"></td>
                    <td></td> 
                </tr>
                `
            );
            
            $(`#${absence.id}-absence-motivated`).change(function() {
                absence_modified = {
                    excused: this.checked,
                    motivation: $(`#${absence.id}-absence-motivation`).val()
                }

                $.ajax
                ({
                    type: "PUT",
                    url: `https://localhost:5001/students/absences/${absence.id}`,
                    contentType: 'application/json',
                    data: JSON.stringify(absence_modified),
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', `Bearer ${localStorage.getItem("prof_token")}`);
                    },
                    success: function (data) {
                        location.reload();
                    },
                    error: function (xhr, textStatus, errorThrown){
                        if(xhr.status == 400){
                            alert("Something went wrong")
                        }else{
                            console.log(xhr)
                            localStorage.removeItem("prof_token");
                            window.location.href = "/login";
                        }
                    }
                })
            });

            $(`#${absence.id}-absence-motivation`).focusout(function(){
                absence_modified = {
                    excused: $(`#${absence.id}-absence-motivated`).prop('checked'),
                    motivation: $(`#${absence.id}-absence-motivation`).val()
                }

                $.ajax
                ({
                    type: "PUT",
                    url: `https://localhost:5001/students/absences/${absence.id}`,
                    contentType: 'application/json',
                    data: JSON.stringify(absence_modified),
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', `Bearer ${localStorage.getItem("prof_token")}`);
                    },
                    success: function (data) {
                        location.reload();
                    },
                    error: function (xhr, textStatus, errorThrown){
                        if(xhr.status == 400){
                            alert("Something went wrong")
                        }else{
                            console.log(xhr)
                            localStorage.removeItem("prof_token");
                            window.location.href = "/login";
                        }
                    }
                })

            })

            

        }
    });

    $("#student-absences").append(`
        <td><input type="date" id="absence-date" name="absence-date"></td>
        <td></td>
        <td></td>
        <td><i id="add-absence" class="far fa-plus-square clickable"></i></td>
    `);


    $("#add-absence").click(function(){
        assignment = {
            student: student_id,
            date: new Date($("#absence-date").val() || new Date()),
        }
        
        $.ajax
        ({
            type: "POST",
            url: 'https://localhost:5001/students/absences',
            contentType: 'application/json',
            data: JSON.stringify(assignment),
            beforeSend: function (xhr) {
                xhr.setRequestHeader('Authorization', `Bearer ${localStorage.getItem("prof_token")}`);
            },
            success: function (data) {
                location.reload();
            },
            error: function (xhr, textStatus, errorThrown){
                if(xhr.status == 400){
                    alert("Something went wrong")
                }else{
                    console.log(xhr)
                    localStorage.removeItem("prof_token");
                    window.location.href = "/login";
                }
            }
        })
    });


}