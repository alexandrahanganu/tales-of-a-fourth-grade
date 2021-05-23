using System;

namespace TalesOfAForthGrade.Api.DTO.Absence
{
    public record UpdateAbsenceDTO{
        public bool excused { get; init; }
        public string motivation { get; init; }
    }
}