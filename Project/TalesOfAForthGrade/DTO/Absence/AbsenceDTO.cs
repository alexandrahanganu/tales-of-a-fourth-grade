using System;

namespace TalesOfAForthGrade.DTO.Absence
{
    public record AbsenceDTO{
        public Guid Id { get; init; }
        public Guid Subject { get; init; }
        public bool excused { get; init; }
        public string motivation { get; init; }
        public DateTimeOffset Date {get; init;}
    }
}