using System.Collections.Generic;
using CRUD.Models.Entites;

namespace CRUD.Models.Repos
{
   
    public class SWrepos // класс имитирующий БД
    {
        private int count = 0;
        private SortedDictionary<int, SW> repos;
        private static SWrepos instnace = null;
        private SWrepos() { repos = new SortedDictionary<int, SW>(); }
        public static SWrepos Instance
        {
            get
            {
                if (instnace == null)
                    instnace = new SWrepos();
                return instnace;
            }
        }

        public void Add(SW sw)
        {
            sw.Id = ++count;
            repos.Add(sw.Id, sw);
        }

        public void Update(SW sw)
        {
            repos.TryGetValue(sw.Id, out SW old);
            old.Update(sw);
        }

        public SW Find(int id)
        {
            repos.TryGetValue(id, out SW sw);
            return sw;
        }

        public void Remove(int id)
        {
            repos.Remove(id);
        }

        public IEnumerable<SW> SWs
        {
            get
            {
                List<SW> res = new List<SW>();
                foreach (var sw in repos)
                    res.Add(sw.Value);
                return res;
            }
        }
    }
}