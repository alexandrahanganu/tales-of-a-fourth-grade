
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using TalesOfAForthGrade.Api.DTO.Absence;
using TalesOfAForthGrade.Api.DTO.Assignment;
using TalesOfAForthGrade.Api.DTO.Grade;
using TalesOfAForthGrade.Api.DTO.Student;
using TalesOfAForthGrade.Api.Entities;
using TalesOfAForthGrade.Api.Repositories;

namespace TalesOfAForthGrade.Api.Services{


    public class StudentServices{
        private readonly IGradesRepository gradesRepository;
        private readonly ISubjectsRepository subjectsRepository;
        private readonly IAbsensesRepository absensesRepository;
        private readonly IAssignmentsRepository assignmentsRepository;

        public StudentServices(
        IGradesRepository gradesRepository, 
        ISubjectsRepository subjectsRepository, 
        IAbsensesRepository absensesRepository,
        IAssignmentsRepository assignmentsRepository){
            this.gradesRepository = gradesRepository;
            this.subjectsRepository = subjectsRepository;
            this.absensesRepository = absensesRepository;
            this.assignmentsRepository = assignmentsRepository;
        }

        public async Task<ActionResult<StudentProfileDTO>> GetStudentProfile(Student student){

            var grades = await gradesRepository.GetGradesStudentAsync(student.Id);

            List<GradeDataDTO> gradesDto = new List<GradeDataDTO>();

            foreach(Grade grade in grades){
                gradesDto.Add(new GradeDataDTO{
                    Subject = (await subjectsRepository.GetSubjectAsync(grade.Subject)).Title,
                    Value = grade.Value,
                    Date = grade.Date
                });
            }

            var absences = await absensesRepository.GetAbsencesStudentAsync(student.Id);

            List<AbsenceDataDTO> absenceDatas = new List<AbsenceDataDTO>();

            foreach(Absence absence in absences){
                absenceDatas.Add(new AbsenceDataDTO{
                    Id = absence.Id,
                    Subject = (await subjectsRepository.GetSubjectAsync(absence.Subject)).Title,
                    excused = absence.excused,
                    motivation = absence.motivation,
                    Date = absence.Date
                });
            }

            var assignments = await assignmentsRepository.GetAssignmentsStudentAsync(student.Id);

            List<AssignmentDataDTO> assignmentDatas = new List<AssignmentDataDTO>();
            
            foreach(Assignment assignment in assignments){
                assignmentDatas.Add(new AssignmentDataDTO{
                    Id = assignment.Id,
                    Student = assignment.Student,
                    Subject = (await subjectsRepository.GetSubjectAsync(assignment.Subject)).Title,
                    Done = assignment.Done,
                    DateFrom = assignment.DateFrom,
                    DateDue = assignment.DateDue
                });
            }

            return student.AsProfileDto(gradesDto, absenceDatas, assignmentDatas);
        }
    }
}