if(!localStorage.getItem("token")){
    window.location.href = "/login"; // To be added after testing
}

$(document).ready(function(){
    $.ajax
    ({
        type: "GET",
        url: 'https://localhost:5001/profile',
        beforeSend: function (xhr) {
            xhr.setRequestHeader('Authorization', `Bearer ${localStorage.getItem("token")}`);
        },
        success: function (data) {
            //console.log(data);
            appendData(data);
        },
        error: function (XMLHttpRequest, textStatus, errorThrown){
            localStorage.removeItem("token");
            window.location.href = "/login";
        }
    })
});

function appendData(data){
    console.log(data);
    $("#student-name").text(`${data.lastName} ${data.firstName}`)

    var subjects = []
    var firstSubject = true; 

    data.grades.forEach(grade => {
        if(subjects.includes(grade.subject)){
            addGrade(grade);
        }else{
            createNewSubject(grade, !firstSubject);
            addGrade(grade);
            firstSubject = false;
            subjects.push(grade.subject)
        }
    });

    data.absences.forEach(absence => {
        if(subjects.includes(absence.subject)){
            addAbsence(absence);
        }else{
            createNewSubject(absence, !firstSubject);
            addAbsence(absence);
            firstSubject = false;
            subjects.push(absence.subject)
        }
    });

    data.assignments.forEach(assignment => {
        if(subjects.includes(assignment.subject)){
            addAssignment(assignment)
        }else{
            createNewSubject(assignment, !firstSubject);
            addAssignment(assignment)
            firstSubject = false;
            subjects.push(assignment.subject)
        }
    });

}

function addAssignment(assignment){
    let [month, date, year] = new Date(assignment.dateDue).toLocaleDateString("en-US").split("/");
    var flag = new Date(Date.now()) <= new Date(assignment.dateDue);
    console.log(flag);
    $(`#${assignment.subject}-assingments`).append(`
    <tr>
        <td>${date}/${month}/${year}</td>
        <td>${assignment.done ? '&#10004;' : (flag ? '<div class="loader"><img src="loading.png" alt="loading"></div>' : '&#x2718;')}</td>
    </tr>
    `);
}

function addGrade(grade){
    let [month, date, year] = new Date(grade.date).toLocaleDateString("en-US").split("/")


    $(`#${grade.subject}-grades`).append(`
        <tr>
            <td>${date}/${month}/${year}</td>
            <td>${grade.value}</td>
        </tr>
    `);
}

function addAbsence(absence){
    let [month, date, year] = new Date(absence.date).toLocaleDateString("en-US").split("/")

    $(`#${absence.subject}-tardies`).append(`
        <tr>
            <td>${date}/${month}/${year}</td>
            <td>${absence.excused ? '&#10004;' : '&#x2718;'}</td>
            <td><input type="text" id="${absence.id}-absence-motivation" value="${absence.motivation}"></td>
        </tr>
    `);

    $(`#${absence.id}-absence-motivation`).focusout(function(){
        absence_modified = {
            excused: absence.excused,
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
                    //localStorage.removeItem("token");
                    //window.location.href = "/login";
                }
            }
        })
    })
}

function createNewSubject(data, hidden){
    $("#subjects").append(`<li class="intrari"><a href="#" class="${hidden ? "" : "active"}" id=${data.subject}> ${data.subject} </a></li>`)

    $(`#${data.subject}`).click(function(){
        $(".active").removeClass("active");
        $(`#${data.subject}`).addClass("active");

        $(".visible").addClass("hidden");
        $(".visible").removeClass("visible");
        $(`#${data.subject}-table`).removeClass("hidden");
        $(`#${data.subject}-table`).addClass("visible");
    })

    $("#student-profile").append(renderSubjectTableHtml(data.subject, hidden))
}

function renderSubjectTableHtml(subjectName, hidden){
    return `<div class="student-table ${hidden ? "hidden" : "visible"}" id="${subjectName}-table">
    <div class="flex-container">
        <div class="flex-item-left">Note
        <table id="${subjectName}-grades">
            <tr>
                <th>Data</th>
                <th>Nota</th>
            </tr>
        </table>
        </div>
        <div class="break"></div>
        <div class="flex-item-center" >Teme
        <table id="${subjectName}-assingments">
            <tr>
                <th>Data Finala</th>
                <th>Facut</th>
            </tr>
        </table>
        </div>
        <div class="flex-item-right">Absente
        <table id="${subjectName}-tardies">
            <tr>
                <th>Data</th>
                <th>Motivata</th>
                <th>Scuza</th>
            </tr>
        </table>
        </div>
    </div>
</div>`
}