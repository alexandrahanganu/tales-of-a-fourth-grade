using System;
using System.Collections.Generic;
using TalesOfAForthGrade.Api.DTO.Absence;
using TalesOfAForthGrade.Api.DTO.Assignment;
using TalesOfAForthGrade.Api.DTO.Grade;

namespace TalesOfAForthGrade.Api.DTO.Student
{
    public record StudentProfileDTO{

        public Guid Id { get; init; }
        public string LastName { get; init; }
        public string FirstName { get; init; }
        public List<GradeDataDTO> Grades { get; init; }
        public List<AbsenceDataDTO> Absences { get; init; }
        public List<AssignmentDataDTO> Assignments { get; init; }
    }
}