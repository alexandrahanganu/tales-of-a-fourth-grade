using System;

namespace TalesOfAForthGrade.Api.DTO.Absence
{
    public record AbsenceDataDTO{
        public Guid Id { get; init; }
        public string Subject { get; init; }
        public bool excused { get; init; }
        public string motivation { get; init; }
        public DateTimeOffset Date {get; init;}
    }
}