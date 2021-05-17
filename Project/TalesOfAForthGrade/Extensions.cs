using System.Collections.Generic;
using TalesOfAForthGrade.DTO.Absence;
using TalesOfAForthGrade.DTO.Assignment;
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
                CNP = student.CNP
            };
        }

        public static StudentProfileDTO AsProfileDto(this Student student, List<GradeDataDTO> grades, List<AbsenceDataDTO> absences, List<AssignmentDataDTO> assignments){
            return new StudentProfileDTO{
                Id = student.Id,
                FirstName = student.FirstName,
                LastName = student.LastName,
                Grades = grades,
                Absences = absences,
                Assignments = assignments
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

        public static ProfessorDataDTO AsDataDto(this Professor professor, string subject){
            return new ProfessorDataDTO{
                Id = professor.Id,
                LastName = professor.LastName,
                FirstName = professor.FirstName,
                Subject = subject,
                username = professor.username
            };
        }

        public static AbsenceDTO AsDto(this Entities.Absence absence){
            return new AbsenceDTO{
                Id = absence.Id,
                Subject = absence.Subject,
                excused = absence.excused,
                motivation = absence.motivation,
                Date = absence.Date
            };
        }

        public static AssignmentDTO AsDto(this Entities.Assignment assignment){
            return new AssignmentDTO{
                Id = assignment.Id,
                Subject = assignment.Subject,
                Done = assignment.Done,
                DateFrom = assignment.DateFrom,
                DateDue = assignment.DateDue
            };
        }
    }
}