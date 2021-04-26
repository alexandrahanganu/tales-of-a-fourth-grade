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
            localStorage.setItem("token", "")
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

        }else{
            createNewSubject(absence, !firstSubject);
            firstSubject = false;
            subjects.push(absence.subject)
        }
    });

    data.assignments.forEach(assignment => {
        if(subjects.includes(assignment.subject)){

        }else{
            createNewSubject(assignment, !firstSubject);
            firstSubject = false;
            subjects.push(assignment.subject)
        }
    });

}

function addGrade(grade){
    let [month, date, year]    = new Date(grade.date).toLocaleDateString("en-US").split("/")


    $(`#${grade.subject}-grades`).append(`
        <tr>
            <td>${date}/${month}/${year}</td>
            <td>${grade.value}</td>
        </tr>
    `);
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
        <div class="flex-item-left">Grades
        <table id="${subjectName}-grades">
            <tr>
                <th>Date</th>
                <th>Grade</th>
            </tr>
        </table>
        </div>
        <div class="break"></div>
        <div class="flex-item-center" >Assignments
        <table id="${subjectName}-assingments">
            <tr>
                <th>Due Date</th>
                <th>Done</th>
            </tr>
        </table>
        </div>
        <div class="flex-item-right">Tardies
        <table id="${subjectName}-tardies">
            <tr>
                <th>Date1</th>
                <th>Excused</th>
                <th>Motivation</th>
            </tr>
        </table>
        </div>
    </div>
</div>`
}