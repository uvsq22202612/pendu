import tkinter as tk
import random
import tkinter.messagebox as messagebox
import pickle

# Définition des mots possibles
liste_mots = ["python", "ordinateur", "programmation", "algorithme", "variable"]

# Sélection d'un mot au hasard
mot_choisi = random.choice(liste_mots)

# Initialisation des variables
lettres_trouvees = []
lettres_fausses = []
nb_coups = 7

# Propose au joueur de continuer à jouer ou arrêter
def fin_partie():
    global mot_choisi, lettres_trouvees, lettres_fausses, nb_coups

    if nb_coups == 0:
        messagebox.showinfo("Fin de partie", "Perdu : le mot était " + mot_choisi)
    else:
        messagebox.showinfo("Fin de partie", "Gagné !")

    if messagebox.askyesno("Nouvelle partie", "Voulez-vous jouer une nouvelle partie ?"):
        # Nouvelle partie
        lettres_trouvees = []
        lettres_fausses = []
        nb_coups = 7
        mot_choisi = random.choice(liste_mots)
        label_mot.config(text=" _" * len(mot_choisi))
        label_lettres_fausses.config(text="")
        affiche_pendu(nb_coups)
        label_resultat.config(text="")
        for bouton in liste_boutons:
            bouton.config(state=tk.NORMAL)
    else:
        # Sauvegarde du score
        score = len(lettres_trouvees)
        sauvegarder_score(score, nb_coups)
        # Quitte le programme
        fenetre.quit()

# Initialisation de la fonction sauvegarder score
def sauvegarder_score(nom, score, nb_coups):
    # Charger les scores précédents depuis le fichier de sauvegarde
    try:
        with open('scores.pickle', 'rb') as f:
            scores = pickle.load(f)
    except FileNotFoundError:
        scores = {}

    # Ajouter le nouveau score au dictionnaire
    scores[nom] = (score, nb_coups)

    # Enregistrer le dictionnaire de scores dans le fichier de sauvegarde
    with open('scores.pickle', 'wb') as f:
        pickle.dump(scores, f)

# Lire les scores
def lire_scores():
    # Charger les scores depuis le fichier de sauvegarde
    try:
        with open('scores.pickle', 'rb') as f:
            scores = pickle.load(f)
    except FileNotFoundError:
        scores = {}
    return scores

# Afficher les scores
def afficher_scores():
    scores = lire_scores()
    if not scores:
        messagebox.showinfo("Scores", "Aucun score enregistré")
    else:
        scores_str = "Scores :\n"
        for nom, (score, nb_coups) in scores.items():
            scores_str += f"{nom} : {score} ({nb_coups} coups restants)\n"
        messagebox.showinfo("Scores", scores_str)

# Aff
