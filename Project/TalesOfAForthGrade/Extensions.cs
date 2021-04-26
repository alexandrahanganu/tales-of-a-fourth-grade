using System.Collections.Generic;
using TalesOfAForthGrade.DTO.Grade;
using TalesOfAForthGrade.DTO.Professor;
using TalesOfAForthGrade.DTO.Student;
using TalesOfAForthGrade.Entities;

namespace TalesOfAForthGrade
{
    public static class Extensions{
        public static StudentDTO AsDto(this Student student){
            return new StudentDTO{
                Id = student.Id,
                FirstName = student.FirstName,
                LastName = student.LastName,
            };
        }

        public static StudentProfileDTO AsProfileDto(this Student student, List<GradeDataDTO> grades){
            return new StudentProfileDTO{
                Id = student.Id,
                FirstName = student.FirstName,
                LastName = student.LastName,
                Grades = grades,
                Absences = new List<GradeDataDTO>(),
                Assignments = new List<GradeDataDTO>()
            };
        }

        public static GradeDTO AsDto(this Grade grade){
            return new GradeDTO{
                Id = grade.Id,
                Student = grade.Student,
                Subject = grade.Subject,
                Value = grade.Value,
                Date = grade.Date  
            };
        }

        public static ProfessorDTO AsDto(this Professor professor){
            return new ProfessorDTO{
                Id = professor.Id,
                LastName = professor.LastName,
                FirstName = professor.FirstName,
                Subject = professor.Subject
            };
        }
    }
}