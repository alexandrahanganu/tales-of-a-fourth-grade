using System;

namespace TalesOfAForthGrade.Api.DTO.Assignment
{
    public record UpdateAssignmentDTO{
        public bool Done {get; init;}
        public DateTimeOffset DateDue { get; init; }
    }
}