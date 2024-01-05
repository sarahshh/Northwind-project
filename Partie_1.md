### Partie 1 création de table et DDL


**Tâche CustomerFeedback :**<br>
1. Créer une nouvelle table appelée 'CustomerFeedback' avec les colonnes:<br>
    - 'FeedbackID',<br>
    - 'CustomerID',<br>
    - 'FeedbackText',<br>
    - 'FeedbackDate'<br>
Il est important de recueillir les retours des clients pour améliorer continuellement nos produits et services.<br>
<br>

2. Ajouter une nouvelle contrainte à la table 'CustomerFeedback' pour garantir que la colonne 'FeedbackDate' ne soit pas nulle.<br>
Cela nous aidera à éviter des erreurs dans notre analyse des retours clients.<br>

**Modification de table existantes et ajout de contraintes de tables :**<br>
1. Ajouter une nouvelle colonne appelée **'CategoryID'** à la table **'Products'** pour catégoriser nos produits de manière plus efficace.<br>
Cela nous aidera à mieux organiser notre catalogue de produits et facilitera la recherche pour nos clients.<br>

2. Ajouter une nouvelle contrainte à la table **'Customers'** pour garantir que la colonne **'CompanyName'** ne soit pas nulle.<br>
Cela nous aidera à maintenir l'intégrité des données et à éviter les erreurs dans nos enregistrements clients.<br>

3. Ajouter une nouvelle contrainte à la table **'Orders'** pour garantir que la colonne **'ShipCity'** ne soit pas nulle.<br>
Cela nous aidera à éviter des erreurs dans notre processus d'expédition et à assurer que les commandes sont livrées à l'endroit correct.<br>

4. Modifier la table **'Products'** pour supprimer la colonne **'Discontinued'**.<br> 
Nous n'avons plus besoin de cette information, et elle encombre notre catalogue de produits.<br>

5. Modifier la table **'Customers'** pour ajouter une nouvelle colonne appelée **'PhoneNumber'** afin de stocker les informations de contact des clients.<br>
Cela nous aidera à mieux communiquer avec nos clients et à fournir un meilleur service client.<br>

**Table OrderItems :**<br>
1. Créer une nouvelle table appelée 'OrderItems' avec les colonnes:<br>
    - 'OrderID',<br> 
    - 'ProductID',<br> 
    - 'Quantity',<br>
    - 'UnitPrice'<br>
Cela nous permettra de suivre les détails de chaque commande et de ses produits associés.<br>
<br>

2. Ajouter une nouvelle contrainte à la table **'OrderItems'** pour garantir que la colonne **'Quantity'** soit supérieure à zéro.<br>
Cela nous aidera à éviter des erreurs dans le traitement de nos commandes et à assurer que les clients reçoivent les quantités correctes de produits.<br>
<br>

3. Ajouter une nouvelle contrainte à la table 'OrderItems' pour garantir que la colonne 'UnitPrice' ne soit pas nulle.<br>
Cela nous aidera à éviter des erreurs dans le traitement de nos commandes et à assurer que les clients soient facturés aux prix corrects pour les produits.<br>
<br>

4. Modifier la table 'OrderItems' pour ajouter une nouvelle contrainte de clé étrangère à la table 'Products'.<br>
Cela garantira que tous les articles de commande soient associés à des enregistrements de produits valides et nous aidera à maintenir l'intégrité des données.<br>

**Table EmployeeSales :**<br>
1. Créer une nouvelle table appelée 'EmployeeSales' avec les colonnes:<br>
    - 'EmployeeID',<br>
    - 'OrderID',<br>
    - 'SalesAmount'<br>

Cela nous permettra de suivre les performances de vente de nos employés et d'identifier les meilleurs performants.<br>
<br>

2. Ajouter une nouvelle contrainte à la table 'EmployeeSales' pour garantir que la colonne 'SalesAmount' soit supérieure à zéro.<br>
Cela nous aidera à garantir que nos données de vente soient précises et à éviter des erreurs dans notre analyse.<br>


**Table SupplierProducts :**<br>
1. Créer une nouvelle table appelée 'SupplierProducts' avec les colonnes:<br>
    - 'SupplierID',<br>
    - 'ProductID',<br>
    - 'Price' <br>

Cela nous permettra de suivre les prix et la disponibilité des produits de nos fournisseurs.<br>