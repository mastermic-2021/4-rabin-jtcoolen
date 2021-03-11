nb = 512;
nbm = 12;
mod = 1<<nbm;
mask = 2*(4^(nbm/2)-1)/(4-1);
n = read("input.txt");
chiffre(m) = [m^2%n,kronecker(m,n),m%2];
dechiffre(c) = read("dec")(c);

\\ On effectue l'attaque à chiffré choisi standard telle que par exemple décrite ici (algorithme randomisé) : http://cacr.uwaterloo.ca/hac/about/chap8.pdf (p. 293, note 8.13(ii)).
\\ Technique également vue en cours dans la démonstration que le problème de factorisation est aussi dur que le problème consistant à casser le cryptosystème de Rabin.
\\ On tire des entiers m\in (Z^n)* aléatoirement et l'on chiffre avec la clé publique n pour obtenir un chiffré `ciphertext`. On présente ensuite ce chiffré à la machine de déchiffrement (dec)
\\ de l'adversaire passif avec l'espoir d'obtenir un clair y tel que ciphertext=y^2=m^2 mod n et y!=±m mod n.
\\ On choisit un nouveau m (terminant par 1010101010 pour être valide) tant que y==0 (chiffré rejeté par la machine de déchiffrement) ou y = m mod n.
\\ Le message se termine par le bit 0 donc est pair, seul le symbole de Kronecker peut varier. Expérimentalement, le symbole de Kronecker -1 convient.
while(1, m=random(1<<500)<<nb+mask; ciphertext=chiffre(m); y=dechiffre([ciphertext[1], -1, 0]); if(y != 0 && y != m, break;); );

\\ n=pq avec p,q premiers (cryptosystème de Rabin employé ici). Donc l'un des deux facteurs (obtenu via le pgcd) est le plus petit facteur de n.
q = gcd(m - y, n);
p = gcd(m + y, n);
print(min(p, q));
