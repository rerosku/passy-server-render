# Partiamo dall’immagine ufficiale di Passy Server
FROM glitterware/passy-server:latest

# Esponiamo la porta HTTPS standard
EXPOSE 443

# L’immagine ufficiale avvia già il server con la variabile d'ambiente PASSY_*
# quindi non serve CMD aggiuntivo se l’immagine è configurata correttamente.

