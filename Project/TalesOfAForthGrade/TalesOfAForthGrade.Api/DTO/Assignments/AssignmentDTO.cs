using System;

namespace TalesOfAForthGrade.Api.DTO.Assignment
{
    public record AssignmentDTO{
        public Guid Id { get; init; }
        public Guid Subject { get; init; }
        public bool Done {get; init;}
        public DateTimeOffset DateFrom { get; init; }
        public DateTimeOffset DateDue { get; init; }
    }
}