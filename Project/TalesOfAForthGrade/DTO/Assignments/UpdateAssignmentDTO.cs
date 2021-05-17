using System;

namespace TalesOfAForthGrade.DTO.Assignment
{
    public record UpdateAssignmentDTO{
        public bool Done {get; init;}
        public DateTimeOffset DateDue { get; init; }
    }
}