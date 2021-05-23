using System;

namespace TalesOfAForthGrade.Api.DTO.Assignment
{
    public record CreateAssignmentDTO{
        public Guid Student { get; init; }
        public DateTimeOffset DateFrom { get; init; }
        public DateTimeOffset DateDue { get; init; }
    }
}