using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Wba.Personen.Lib.Entities
{
    [Serializable]
    public class Persoon
    {
        public string ID { get; }
        public string Naam { get; set; }
        public string Voornaam { get; set; }
        public DateTime Geboortedatum { get; set; }
        public bool IsMan { get; set; }
        public string Leeftijd
        {
            get
            {
                return GetLeeftijd();
            }
        }

        public Persoon()
        {
            ID = Guid.NewGuid().ToString();
        }
        public Persoon(string naam, string voornaam, DateTime geboortedatum, bool isman)
        {
            ID = Guid.NewGuid().ToString();
            Naam = naam;
            Voornaam = voornaam;
            Geboortedatum = geboortedatum;
            IsMan = isman;
        }

        public override string ToString()
        {
            return $"{Naam} {Voornaam}";
        }
        public string GetLeeftijd()
        {
            DateTime vandaag = DateTime.Now;
            TimeSpan verschil = vandaag - Geboortedatum;
            DateTime leeftijd = DateTime.MinValue + verschil;
            return $"{leeftijd.Year} jaar, {leeftijd.Month} maanden en {leeftijd.Day} dagen";
        }

    }

}
