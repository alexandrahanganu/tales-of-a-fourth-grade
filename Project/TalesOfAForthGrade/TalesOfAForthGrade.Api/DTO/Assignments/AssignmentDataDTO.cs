using System;

namespace TalesOfAForthGrade.Api.DTO.Assignment
{
    public record AssignmentDataDTO{
        public Guid Id { get; init; }
        public Guid Student { get; init; }
        public string Subject { get; init; }
        public bool Done {get; init;}
        public DateTimeOffset DateFrom { get; init; }
        public DateTimeOffset DateDue { get; init; }
    }
}