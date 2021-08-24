using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Wba.Personen.Lib.Entities;

namespace Wba.Personen.Lib.Services
{
    [Serializable]
    public class PersoonService
    {
        public List<Persoon> Personen { get; private set; }

        public PersoonService()
        {
            Personen = new List<Persoon>();
            CreateMockData();
            OrderList();
        }
        private void CreateMockData()
        {
            Personen.Add(new Persoon("Janssens", "Wim", new DateTime(1995, 12, 24), true));
            Personen.Add(new Persoon("Willems", "Jan", new DateTime(1985, 5, 1), true));
            Personen.Add(new Persoon("Pieters", "Mia", new DateTime(1999, 12, 3), false));
            Personen.Add(new Persoon("Abeels", "Wilma", new DateTime(2003, 7, 23), false));
            Personen.Add(new Persoon("Taer", "Guy", new DateTime(1990, 1, 1), true));
        }
        public void OrderList()
        {
            Personen = Personen.OrderBy(o => o.Naam).ThenBy(o => o.Voornaam).ToList();
        }
        public void VoegPersoonToe(Persoon persoon)
        {
            Personen.Add(persoon);
            OrderList();
        }
        public void VerwijderPersoon(Persoon persoon)
        {
            Personen.Remove(persoon);
            OrderList();
        }
        public Persoon GetPersoon(string id)
        {
            foreach(Persoon persoon in Personen)
            {
                if (persoon.ID == id)
                    return persoon;
            }
            return null;
        }
    }
}
