
namespace CRUD.Models.Entites
{
    public class SW // класс сабвуфер
    {
        public SW()
        {

        }
        public SW
            (
            string model, string manufacturer,
            int diameter, int max,
            int rms, double dCoil,
            double iDepth, double iDiam, int id = 0
            )
        {
            this.Id = id;
            this.Model = model;
            this.Manufacturer = manufacturer;
            this.Diameter = diameter;
            this.Max = max;
            this.RMS = rms;
            this.DCoil = dCoil;
            this.IDepth = iDepth;
            this.IDiam = iDiam;
        }
        public void Update(SW other)
        {
            Id = other.Id;
            Model = other.Model;
            Manufacturer = other.Manufacturer;
            Diameter = other.Diameter;
            Max = other.Max;
            RMS = other.RMS;
            DCoil = other.DCoil;
            IDepth = other.IDepth;
            IDiam = other.IDiam;
        }
        public int Id { get; set; }
        public string Model { get; set; } 
        public string Manufacturer { get; set; }
        public int Diameter { get; set; }
        public int Max { get; set; }
        public int RMS { get; set; }
        public double DCoil { get; set; }
        public double IDepth { get; set; }
        public double IDiam { get; set; }
    }
}