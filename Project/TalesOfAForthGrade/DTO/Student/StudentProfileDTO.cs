using System;
using System.Collections.Generic;
using TalesOfAForthGrade.DTO.Grade;

namespace TalesOfAForthGrade.DTO.Student
{
    public record StudentProfileDTO{

        public Guid Id { get; init; }
        public string LastName { get; init; }
        public string FirstName { get; init; }
        public List<GradeDataDTO> Grades { get; init; }
        public List<GradeDataDTO> Absences { get; init; }
        public List<GradeDataDTO> Assignments { get; init; }
    }
}