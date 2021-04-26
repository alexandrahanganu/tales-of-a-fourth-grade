using System;

namespace TalesOfAForthGrade.DTO.Absence
{
    public record UpdateAbsenceDTO{
        public bool excused { get; init; }
        public string motivation { get; init; }
    }
}