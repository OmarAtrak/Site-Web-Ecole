using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Ecoule
{
    public class Personne : Connection
    {
        // les attribut
        private string nom;
        private string prenom;
        private string tele;
        private DateTime dateNaissance;
        private string adresse;
        private string sexe;
        private string mot_passe;


        // les proprietes
        public string Nom { get => nom; set => nom = value; }
        public string Prenom { get => prenom; set => prenom = value; }
        public string Tele { get => tele; set => tele = value; }
        public DateTime DateNaissance { get => dateNaissance; set => dateNaissance = value; }
        public string Adresse { get => adresse; set => adresse = value; }
        public string Sexe { get => sexe; set => sexe = value; }
        public string Mot_passe { get => mot_passe; set => mot_passe = value; }



        // constrecture d'initialisation
        public Personne() { }



        // constrecture d'initialisation
        public Personne(string nom, string prenom, string tele, DateTime dateNaissance,
                        string adresse, string sexe, string mot_passe)
        {
            this.Nom = nom;
            this.Prenom = prenom;
            this.Tele = tele;
            this.DateNaissance = dateNaissance;
            this.Adresse = adresse;
            this.Sexe = sexe;
            this.Mot_passe = mot_passe;
        }
    }
}