if(!localStorage.getItem("token-admin")){
    window.location.href = "/admin"; // To be added after testing
}

$.ajax
    ({
        type: "GET",
        url: 'https://localhost:5001/students/info',
        contentType: 'application/json',
        beforeSend: function (xhr) {
            xhr.setRequestHeader('Authorization', `Bearer ${localStorage.getItem("token-admin")}`);
        },
        success: function (data) {
            populateStudentTable(data);
        },
        error: function (XMLHttpRequest, textStatus, errorThrown){
            localStorage.removeItem("token-admin");
            window.location.href = "/admin";
        }
    })

$.ajax
    ({
        type: "GET",
        url: 'https://localhost:5001/professor',
        contentType: 'application/json',
        beforeSend: function (xhr) {
            xhr.setRequestHeader('Authorization', `Bearer ${localStorage.getItem("token-admin")}`);
        },
        success: function (data) {
            populateProfessorsTable(data);
        },
        error: function (XMLHttpRequest, textStatus, errorThrown){
            localStorage.removeItem("token-admin");
            window.location.href = "/admin";
        }
    })

function populateStudentTable(students){
    students.forEach(student => {
        $("#students-table").append(getRowHTML(student));

        $(`#delete-${student.id}`).click(function(){
            $.ajax
            ({
                type: "DELETE",
                url: `https://localhost:5001/students/info/${student.id}`,
                contentType: 'application/json',
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', `Bearer ${localStorage.getItem("token-admin")}`);
                },
                success: function (data) {
                    location.reload();
                },
                error: function (xhr, textStatus, errorThrown){
                    if(xhr.status == 404){
                        alert("Something went wrong. The User Requested was not found")
                    }else{
                        localStorage.removeItem("token-admin");
                        window.location.href = "/admin";
                    }
                }
            })
        });

        $(`#modify-${student.id}`).click(function(){
            updatedStudent = {
                lastName: $(`#lname-${student.id}`).val(),
                firstName: $(`#fname-${student.id}`).val(),
                cnp: $(`#cnp-${student.id}`).val()
            }

            $.ajax
            ({
                type: "PUT",
                url: `https://localhost:5001/students/info/${student.id}`,
                contentType: 'application/json',
                data: JSON.stringify(updatedStudent),
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', `Bearer ${localStorage.getItem("token-admin")}`);
                },
                success: function (data) {
                    location.reload();
                },
                error: function (xhr, textStatus, errorThrown){
                    if(xhr.status == 404){
                        alert("Something went wrong. The User Requested was not found")
                    }else{
                        //console.log(errorThrown);
                        localStorage.removeItem("token-admin");
                        window.location.href = "/admin";
                    }
                }
            })
        });

        $(`#lname-${student.id}`).on("input", function(){
            $(`#lname-${student.id}`).addClass("blue");
        });

        $(`#fname-${student.id}`).on("input", function(){
            $(`#fname-${student.id}`).addClass("blue");
        });

        $(`#cnp-${student.id}`).on("input", function(){
            $(`#cnp-${student.id}`).addClass("blue");
        });
    });

}

function getRowHTML(student){
    return `
    <tr id="${student.id}">
                <td>
                    <input type="text" id="lname-${student.id}" name="lname" value="${student.lastName}">
                </td>
                <td> 
                    <input type="text" id="fname-${student.id}" name="fname" value="${student.firstName}">
                </td>
                <td id="unique-id-${student.id}">${student.id}</td>
                <td>
                    <input type="text" id="cnp-${student.id}" name="cnp" value="${student.cnp}">
                </td>
                <td>
                    <i class="fas fa-edit clickable" id="modify-${student.id}"></i>
                </td>
                <td>
                    <i class="fas fa-trash clickable" id="delete-${student.id}"></i>
                </td>
            </tr>
    `
}

function populateProfessorsTable(professors){
    console.log(professors);
    professors.forEach(professor => {
        $("#profs-table").append(getProffesorRowHTML(professor));

        $(`#delete-${professor.id}`).click(function(){
            $.ajax
            ({
                type: "DELETE",
                url: `https://localhost:5001/professor/${professor.id}`,
                contentType: 'application/json',
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', `Bearer ${localStorage.getItem("token-admin")}`);
                },
                success: function (data) {
                    location.reload();
                },
                error: function (xhr, textStatus, errorThrown){
                    if(xhr.status == 404){
                        alert("Something went wrong. The User Requested was not found")
                    }else{
                        localStorage.removeItem("token-admin");
                        window.location.href = "/admin";
                    }
                }
            })
        });

        $(`#modify-${professor.id}`).click(function(){
            updatedProfessor = {
                lastName: $(`#lname-${professor.id}`).val(),
                firstName: $(`#fname-${professor.id}`).val(),
                subject: $(`#subject-${professor.id}`).val()
            }

            console.log(JSON.stringify(updatedProfessor));

            $.ajax
            ({
                type: "PUT",
                url: `https://localhost:5001/professor/${professor.id}`,
                contentType: 'application/json',
                data: JSON.stringify(updatedProfessor),
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', `Bearer ${localStorage.getItem("token-admin")}`);
                },
                success: function (data) {
                    location.reload();
                },
                error: function (xhr, textStatus, errorThrown){
                    if(xhr.status == 404){
                        alert("Something went wrong. The User Requested was not found")
                    }else{
                        console.log(errorThrown);
                        //localStorage.removeItem("token-admin");
                        //window.location.href = "/admin";
                    }
                }
            })
        });

        $(`#lname-${professor.id}`).on("input", function(){
            $(`#lname-${professor.id}`).addClass("blue");
        });

        $(`#fname-${professor.id}`).on("input", function(){
            $(`#fname-${professor.id}`).addClass("blue");
        });

        $(`#subject-${professor.id}`).on("input", function(){
            $(`#subject-${professor.id}`).addClass("blue");
        });
    });
}

function getProffesorRowHTML(professor){
    return `
    <tr id="${professor.id}">
                <td>
                    <input type="text" id="lname-${professor.id}" name="lname" value="${professor.lastName}">
                </td>
                <td> 
                    <input type="text" id="fname-${professor.id}" name="fname" value="${professor.firstName}">
                </td>
                <td id="unique-id-${professor.id}">${professor.id}</td>
                <td>${professor.username}</td>
                <td> 
                    <input type="text" id="subject-${professor.id}" name="fname" value="${professor.subject}">
                </td>
                <td>
                    <i class="fas fa-edit clickable" id="modify-${professor.id}"></i>
                </td>
                <td>
                    <i class="fas fa-trash clickable" id="delete-${professor.id}"></i>
                </td>
            </tr>
    `
}

$("#ex-studs").click(function(){
    window.open("/example-students.csv", '_blank').focus();
});

$("#ex-profs").click(function(){
    window.open("/example-professors.csv", '_blank').focus();
});

$("#add-stud").click(function(){
    var input = document.createElement('input');
    input.type = 'file';
    input.accept = ".csv";

    input.onchange = e => { 

        // getting a hold of the file reference
        var file = e.target.files[0]; 

        // setting up the reader
        var reader = new FileReader();
        reader.readAsText(file,'UTF-8');

        // here we tell the reader what to do when it's done reading...
        reader.onload = readerEvent => {
            var content = readerEvent.target.result; // this is the content!
            data = CSVToArray(content, ',');
            data.shift();
            
            students = [];
            data.forEach(student => {
                students.push({
                    lastName: student[0],
                    firstName: student[1],
                    cnp: student[2] 
                })
            });
            exportStudents(students);
        }

    }

    input.click();

});

function exportStudents(students){
    $.ajax
    ({
        type: "POST",
        url: 'https://localhost:5001/students/info/list',
        contentType: 'application/json',
        data: JSON.stringify(students),
        beforeSend: function (xhr) {
            xhr.setRequestHeader('Authorization', `Bearer ${localStorage.getItem("token-admin")}`);
        },
        success: function (data) {
            rows = []
            header = ["id", "Nume", "Prenume", "CNP", "Parola"]

            rows.push(header);

            data.forEach(student => {
                rows.push([`${student.id}`,`${student.lastName}`,`${student.firstName}`,`${student.cnp}`,`${student.password}`]);
            });

            let csvContent = "data:text/csv;charset=utf-8,";

            rows.forEach(function(rowArray) {
                let row = rowArray.join(",");
                csvContent += row + "\r\n";
            });

            var encodedUri = encodeURI(csvContent);
            var link = document.createElement("a");
            link.setAttribute("href", encodedUri);
            link.setAttribute("download", "student_data.csv");
            document.body.appendChild(link); // Required for FF

            link.click();
        },
        error: function (xhr, textStatus, errorThrown){
            if(xhr.status == 400){
                alert("CSV is not valid. Check for blank lines in the end.")
            }else{
                localStorage.removeItem("token-admin");
                window.location.href = "/admin";
            }
        }
    })
}

$("#add-prof").click(function(){
    var input = document.createElement('input');
    input.type = 'file';
    input.accept = ".csv";

    input.onchange = e => { 

        // getting a hold of the file reference
        var file = e.target.files[0]; 

        // setting up the reader
        var reader = new FileReader();
        reader.readAsText(file,'UTF-8');

        // here we tell the reader what to do when it's done reading...
        reader.onload = readerEvent => {
            var content = readerEvent.target.result; // this is the content!
            data = CSVToArray(content, ',');
            data.shift();
            
            profs = [];
            data.forEach(prof => {
                profs.push({
                    lastName: prof[0],
                    firstName: prof[1],
                    subject: prof[2] 
                })
            });
            exportProfs(profs);
        }

    }

    input.click();

});


function exportProfs(profs){
    $.ajax
    ({
        type: "POST",
        url: 'https://localhost:5001/professor/list',
        contentType: 'application/json',
        data: JSON.stringify(profs),
        beforeSend: function (xhr) {
            xhr.setRequestHeader('Authorization', `Bearer ${localStorage.getItem("token-admin")}`);
        },
        success: function (data) {
            rows = []
            header = ["id", "Nume", "Prenume", "Subject", "Username", "Parola"]

            rows.push(header);

            data.forEach(prof => {
                rows.push([`${prof.id}`,`${prof.lastName}`,`${prof.firstName}`,`${prof.subject}`,`${prof.username}`,`${prof.password}`]);
            });

            let csvContent = "data:text/csv;charset=utf-8,";

            rows.forEach(function(rowArray) {
                let row = rowArray.join(",");
                csvContent += row + "\r\n";
            });

            var encodedUri = encodeURI(csvContent);
            var link = document.createElement("a");
            link.setAttribute("href", encodedUri);
            link.setAttribute("download", "prof_data.csv");
            document.body.appendChild(link); // Required for FF

            link.click();
        },
        error: function (xhr, textStatus, errorThrown){
            if(xhr.status == 400){
                alert("CSV is not valid. Check for blank lines in the end.")
            }else{
                localStorage.removeItem("token-admin");
                window.location.href = "/admin";
            }
        }
    })
}


function CSVToArray( strData, strDelimiter ){
    // Check to see if the delimiter is defined. If not,
    // then default to comma.
    strDelimiter = (strDelimiter || ",");

    // Create a regular expression to parse the CSV values.
    var objPattern = new RegExp(
        (
            // Delimiters.
            "(\\" + strDelimiter + "|\\r?\\n|\\r|^)" +

            // Quoted fields.
            "(?:\"([^\"]*(?:\"\"[^\"]*)*)\"|" +

            // Standard fields.
            "([^\"\\" + strDelimiter + "\\r\\n]*))"
        ),
        "gi"
        );


    // Create an array to hold our data. Give the array
    // a default empty first row.
    var arrData = [[]];

    // Create an array to hold our individual pattern
    // matching groups.
    var arrMatches = null;


    // Keep looping over the regular expression matches
    // until we can no longer find a match.
    while (arrMatches = objPattern.exec( strData )){

        // Get the delimiter that was found.
        var strMatchedDelimiter = arrMatches[ 1 ];

        // Check to see if the given delimiter has a length
        // (is not the start of string) and if it matches
        // field delimiter. If id does not, then we know
        // that this delimiter is a row delimiter.
        if (
            strMatchedDelimiter.length &&
            strMatchedDelimiter !== strDelimiter
            ){

            // Since we have reached a new row of data,
            // add an empty row to our data array.
            arrData.push( [] );

        }

        var strMatchedValue;

        // Now that we have our delimiter out of the way,
        // let's check to see which kind of value we
        // captured (quoted or unquoted).
        if (arrMatches[ 2 ]){

            // We found a quoted value. When we capture
            // this value, unescape any double quotes.
            strMatchedValue = arrMatches[ 2 ].replace(
                new RegExp( "\"\"", "g" ),
                "\""
                );

        } else {

            // We found a non-quoted value.
            strMatchedValue = arrMatches[ 3 ];

        }


        // Now that we have our value string, let's add
        // it to the data array.
        arrData[ arrData.length - 1 ].push( strMatchedValue );
    }

    // Return the parsed data.
    return( arrData );
}

$("#search-bar").on("input", function(){
    value = $("#search-bar").val();

    if(value != "" && value != undefined){
        $('table > tbody  > tr').each(function(index, tr) { 
            id = $(tr).attr("id");
            if(($(`#lname-${id}`).val().toLowerCase().startsWith(value.toLowerCase())) || ($(`#fname-${id}`).val().toLowerCase().startsWith(value.toLowerCase()))){
                $(tr).remove("hidden");
            }else{
                $(tr).addClass("hidden");
            }
        });
    }else{
        $('table > tbody  > tr').each(function(index, tr) { 
            $(tr).removeClass("hidden");
        });
    }
});

$("#show-studs").click(function(){
    $("#students-list").removeClass("hidden");
    $("#profs-list").addClass("hidden");
    $("#table-title").text("Students");
});

$("#show-profs").click(function(){
    $("#students-list").addClass("hidden");
    $("#profs-list").removeClass("hidden");
    $("#table-title").text("Professors");
})