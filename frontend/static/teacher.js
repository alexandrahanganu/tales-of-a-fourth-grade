if(!localStorage.getItem("prof_token")){
    //window.location.href = "/login"; // To be added after testing
}

$(document).ready(function(){
    $.ajax
    ({
        type: "GET",
        url: 'https://localhost:5001/professor/abcd',
        beforeSend: function (xhr) {
            xhr.setRequestHeader('Authorization', `Bearer ${localStorage.getItem("prof_token")}`);
        },
        success: function (data) {
            console.log(data);
            $("#prof-name").text(data.lastName + " " + data.firstName);
            $("#subject-name").text(data.subject);
        },
        error: function (XMLHttpRequest, textStatus, errorThrown){
            //localStorage.setItem("token", "")
            //window.location.href = "/login";
        }
    })

    $.ajax
    ({
        type: "GET",
        url: 'https://localhost:5001/students/info',
        beforeSend: function (xhr) {
            xhr.setRequestHeader('Authorization', `Bearer ${localStorage.getItem("prof_token")}`);
        },
        success: function (data) {
            appendData(data);
        },
        error: function (XMLHttpRequest, textStatus, errorThrown){
            //localStorage.setItem("token", "")
            //window.location.href = "/login";
        }
    })
});


function dynamicSort(property) {
    var sortOrder = 1;
    if(property[0] === "-") {
        sortOrder = -1;
        property = property.substr(1);
    }
    return function (a,b) {
        /* next line works with strings and numbers, 
         * and you may want to customize it to your needs
         */
        var result = (a[property] < b[property]) ? -1 : (a[property] > b[property]) ? 1 : 0;
        return result * sortOrder;
    }
}

function dynamicSortMultiple() {

    var props = arguments;
    return function (obj1, obj2) {
        var i = 0, result = 0, numberOfProperties = props.length;
        while(result === 0 && i < numberOfProperties) {
            result = dynamicSort(props[i])(obj1, obj2);
            i++;
        }
        return result;
    }
}

function appendData(students){
    students.sort(dynamicSortMultiple("lastName", "firstName"))
    students.forEach(student => {
        $("#students-table").append(getStudentTableHTML(student))

        $(`#modify-${student.id}`).click(function(){
            location.href = `/student?id=${student.id}`
        });
    });
}

$("#search-bar").on("input", function(){
    value = $("#search-bar").val();

    if(value != "" && value != undefined){
        $('table > tbody  > tr').each(function(index, tr) { 
            id = $(tr).attr("id");
            if(($(`#lname-${id}`).text().toLowerCase().startsWith(value.toLowerCase())) || ($(`#fname-${id}`).text().toLowerCase().startsWith(value.toLowerCase()))){
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

function getStudentTableHTML(student){
    return `
    <tr id=${student.id}>
    <td id=lname-${student.id}>${student.lastName}</td>
    <td id=fname-${student.id}>${student.firstName}</td>
    <td id=modify-${student.id}><i class="fas fa-pen-square clickable"></i></td>
    </tr>
    `
}