# Projet IN213

`Lammp` est un langage de description de shaders, destiné à être "compilé" en code ISF (https://isf.video).
Il restera en mémoire comme nettement plus amusant à inventer qu'à implémenter, et plus agréable à implémenter qu'à utiliser.

Pour lire rapidement cette documentation, vous pouvez vous contenter de lire à partir de **Principes**.

## Contexte

Dans le cadre des soirées de l'ENSTA et d'autres écoles qui font appel à nos services, nous créons des animations vidéo que nous projetons sur des écrans.

Pour cela nous écrivons des (fragment) shaders : des petits morceaux de code avec une fonction principale : attribuer une couleur à chaque pixel, en fonction de sa position sur l'écran (et eventuellement d'autes variables appelées "uniforms" : elles ne dépendent pas de la position sur l'écran). Avec des outils adaptés (HeavyM, MadMapper, ISF...) ces shaders sont chargés sur la carte graphique du PC de notre régie vidéo et le résultat est affiché à l'aide de nos vidéoprojecteurs.

Ces shaders sont écrit dans des langages spéciaux, souvent GLSL ou ISF (un  GLSL modifié). https://isf.video permet de créer ces shaders avec un aperçu en temps réel, depuis un navigateur. Ces langages ont une syntaxe type C, et le code de shaders sophistiqués est très rapidement "indigeste".

Par exemple https://editor.isf.video/shaders/5e7a80367c113618206decf6 : 
```
float N1(float n) {
	return fract(sin(n) * 43758.5453123);
}

float N11(float p) {
	float fl = floor(p);
	float fc = fract(p);
	return mix(N1(fl), N1(fl + 1.0), fc);
} 

float N21(vec2 p) { return fract(sin(p.x * floor(seed1) + p.y * floor(seed2)) * floor(seed2+seed1)); }

vec2 N22(vec2 p) { return vec2(N21(p), N21(p + floor(seed2))); }

float L(vec2 p, vec2 a, vec2 b) {
	vec2 pa = p-a, ba = b-a;
	float t = clamp(dot(pa, ba)/dot(ba, ba), 0.0, 1.0);
	float d = length(pa - ba * t);
	float m = S(0.02, 0.0, d);
	d = length(a-b);
	float f = S(1.0, 0.8, d);
	m *= f;
	m += m*S(0.05, 0.06, abs(d - 0.5)) * 2.0;
	return m;
}

vec2 GetPos(vec2 p, vec2 o) {
	p += o;
	vec2 n = N22(p)*TIME*rate;
	p = sin(n) * line;
	return o+p;
}

float G(vec2 uv) {
	vec2 id = floor(uv);
	uv = fract(uv) - 0.5;
	vec2 g = GetPos(id, vec2(0));
	float m = 0.0;
	for(float y=-1.0; y<=1.0; y++) {
		for(float x=-1.0; x<=1.0; x++) {
			vec2 offs = vec2(x, y);
			vec2 p = GetPos(id, offs);
			m+=L(uv, g, p);
			vec2 a = p-uv;
			float f = 0.003/dot(a, a);
			f *= pow( sin(N21(id+offs) * 6.2831 + (flash*TIME)) * 0.4 + 0.6, flash);
			m += f;
		}
	}
	m += L(uv, GetPos(id, vec2(-1, 0)), GetPos(id, vec2(0, -1)));
	m += L(uv, GetPos(id, vec2(0, -1)), GetPos(id, vec2(1, 0)));
	m += L(uv, GetPos(id, vec2(1, 0)), GetPos(id, vec2(0, 1)));
	m += L(uv, GetPos(id, vec2(0, 1)), GetPos(id, vec2(-1, 0)));
	return m;
}

void main() 
{
	vec2 uv = (2.25 - scale) * ( gl_FragCoord.xy - 0.5 * RENDERSIZE.xy) / RENDERSIZE.y;
	if (mirror) { if(uv.x<0.0) uv.x = abs(uv.x); }
	float m = 0.0;
	vec3 col;
	for(float i=0.0; i<1.0; i+=0.2) {
		float z = fract(i+TIME*zoom);
		float s = mix(10.0, 0.5, z);
		float f = S(0.0, 0.4, z) * S(1.0, 0.8, z);
		m += G(uv * s + (N11(i)*100.0) * i) * f;
	}
	if (color) { col = 0.5 + sin(vec3(1.0, 0.5, 0.75)*TIME*cycle) * 0.5; }
	else col = vec3(1.0);
	col *= m; 
	gl_FragColor = vec4( col, 1.0 );
}
```

## Objectifs

L'objectif est donc d'imaginer et implémenter un langage permet de simplifier (et raccourcir) l'écriture de shaders pour cette utilisation.

Les objectifs sont donc d'abord :
- raccourcir l'écriture d'un shader simple
- simplifier l'écriture de transformations linéaires (translation, rotation, ...)
- avoir un code plus facile à lire que GLSL
- simplifier l'utilisation de ray-tracing et SDFs

#### Effets "simples"
On veut pouvoir combiner facilement des effets simples : créer des formes géometriques, les placer sur l'écran, créer des effets de couleur (dégradés, bandes, etc...).
HeavyM est un logiciel de mapping de projection : il effectue un rendu en temps réel, éventuellement synchronisé à une musique. Il est conçu pour être utilisé avec des vidéoprojecteurs pour le projeter sur des surfaces.
On peut lui fournir des shaders pour élargir le champ des effets possibles.
On prend donc d'abord exemple sur les effets proposés pour HeavyM, dont d'abord :
    - des bandes de couleurs
    - des polygones
    - des contours
    - des dégradés
    - des animations des effets précédents

#### Transformations linéaires

Pour écrire ces shaders, on utilise beaucoup de combinaisons de transformations basiques:
    - des homotéties pour dimensionner les formes géométriques
    - des translations pour les placer
    - des rotations pour ...
    
On introduit alors les principes de base du langage:
La finalité est de créer une fonction qui donne la couleur d'un pixel en fonction de sa position et du temps (et éventuellement de paramètres supplémentaires, mais on oublie pour l'instant).

#### Ray-tracing et SDF (grosse parenthèse, finalement pas implémenté, mais c'est intéressant)
On utilise pour des effets complexe (avec des visuels 3D) du Ray Tracing avec des **Signed Distance Functions (SDF)** (https://en.wikipedia.org/wiki/Signed_distance_function) que l'on utilise souvent pour décrire des scènes 3D rendues à l'aide de RayTracing.
Effectivement, un (fragment) shader donne une couleur à un pixel en fonction de sa position. Lorsque nous souhaitons créer des effets 3D, nous transormons la position (2D) du pixel en angles, que nous utilisons comme direction pour un rayon. Pour détecter la collision du rayon avec un objet, on avance progressivement (de façon discrète) sur le rayon et on mesure à pour chaque point la distance à l'objet. Par exemple, la SDF d'une sphère de rayon `r0` est `SDF(r) = r - r0` où `r` est la distance au centre.
Pour cela on crée la SDF du l'objet : un champ 3D qui associe à chaque point de l'espace sa distance à l'objet (et a une valeur négative à l'intérieur de l'objet). Lorsque que le signe de la SDF devient négatif lors du parcours de rayon, on "entre" dans l'objet.

## Principes

On définit donc un "**état**" (finalement un struct, littéralement) comme la donnée:
- **de la position X du pixel**
- **de la position Y du pixel**
- **du temps**

Alors, on définit les types:
- **Une région (de l'écran) est une fonction booléenne de l'état : true si le pixel est dans la région, false sinon.**
- **Une transformation est une fonction qui prend un état, et retourne un état modifié.**
- **Un coloriage est une fonction de l'état qui retourne une couleur, soit un vecteur à 4 composantes (Rouge, Vert, Bleu, Opacité).**

À partir de ces définitions, le principe du langage est de décrire et combiner des régions, des transformations et des coloriages pour créer un coloriage final : c'est le shader (puisque c'est une couleur en fonction de la position du pixel).

Le langage est "compilé" en un shader ISF, on peut le tester sur https://isf.video

En ISF ou GLSL, il est fréquent de combiner beaucoup de transformations les unes après les autres, en empilant les parenthèses. On introduira une syntaxe pour le faire facilement et intuitivement (de gauche à droite).

Puisque quasiment tout est une fonction de l'état, on introduit un concept important pour comprendre le langage : **tout est implicitement une fonction de l'état**. On fait alors l'amalgame entre les types nommés ci-dessus : un float est un signal, un bool est une région, etc... On fait en réalité double amalgame, puisque ces signaux, régions, etc...
Aussi, tous les types sont des fonctions sous-entendues, mais elles peuvent chacune prendre des arguments supplémentaires. Un peu plus de clarté viendra avec la description de la syntaxe et ses exemples.

Chaque variable correspondra après la compilation à une fonction ISF, qui prend au moins un argument : l'état (un struct state).

## Syntaxe avec exemple

Il existe quelques éléments de syntaxe non triviaux :
- `:` permet de composer des transformations, pour éviter ce qui serait en ISF de la forme `trans1(trans2(trans3(args_trans3),args_trans2),args_trans1)` on introduit le `:`, qui compose de gauche à droite des transformations, qui se passent l'état modifier d'étape en étape.
Par exemple : `tranlation(tx,ty):scale(factor):rotate(angle)` est une transformation, qui applique d'abord une translation à l'état (argument implicite), qui prend des arguments supplémentaires décrivant la translation, puis applique à cet état modifié une homotétie, puis une rotation avec chacunes leurs arguments.
À la fin de cette chaîne, on peut passer l'état modifié à une fonction, encore avec `:`, par exemple `translate(0.2,0.2):square(0.1)` créera une région correspondant à un carré décalé sur l'écran.
`:` est associatif à gauche : on applique les transformations dans l'ordre de gauche à droite, volontairement pour être plus facile à lire.
- `+` pour les régions : `region1 + region2` correspond à l'union des régions  region1 et region2. Il sera compilé en quelques chose de la forme `region1(...) || region2(...)`
- `-` pour les régions : `region1 - region2` correpond à la région `region1` privée de `region2`
- `*` pour les régions : pour deux régions, `region1 * region2` correspond à l'intersection des régions. Pour les autres types, `region*anything` correpond à `anything` dans la région `region`, une valeur par défaut en dehors de la région (qui dépend du type de `anything`).
- `variable(arguments) = expression;` est la forme de toutes les lignes à part la dernière. On définit une nouvelle variable, toujours fonction d'un état, avec éventuellement d'autres arguments. Si il n'y en a pas d'autes, on omet les parenthèses.
- `return expression` est la forme de la dernière ligne. `expression` doit être de type `vec4`, c'est à dire une couleur (en fonction de l'état). Cela correpondra une fois compilée à la fonction main, qui construira un struct state avec les données de l'état, le donnera à l'expression, et donnera la couleur décrite au pixel courant.
(la fonction `main` du shader est executée pour chaque pixel, elle donne une valeur à gl_FragColor à partir de gl_FragCoords et TIME, variables globales d'ISF)

Cet exemple regroupe la plupart des fonctionnalités implémentées :
```
scalefactor = 0.1;
redcos = (cos(x)+1)/2;
region1 = square(0.1);
region2 = scale(0.9):region1;
region3 = region1-region2;
color1 = (scale(0.01):redcos,1,1,1);                                
color2 = (translate(0.2,0.1)):region3*color1; 
return color2;    
```


- scalefactor est une constante, mais est quand même une fonction constante de l'état, il sera compilé en une fonction `float scalefactor(state s) { return 0.1; }`
- redcos est un coloriage, il sera compilé en une fonction de signature `vec4 redcos(state s)`, il décrit des barres verticales cyan sur fond blanc (vert et bleu constants à 100%, rouge varies selon cos(x)).
- region1 est une région, il utilise la fonction standard `square` : une région correspondant à un carré de côté l'argument donné.
- region2 est la composition de la transformation standard `scale` avec `region1`, soit la même en un peu plus petit
- region3 est la région 1 privée de la 2, elle décrit douce un "carré avec une épaisseur"
- `color1` est un coloriage qui décrit des bandes cyan, 100 fois plus petites que redcos.
- `color2` est le coloriage final, il décrit des petites bandes cyan verticales, sur un carré avec un épaisseur, décalé du centre.

Une fois compilé, le code ISF généré est le suivant :
```
/*{
	"DESCRIPTION": "",
	"CREDIT": "",
	"ISFVSN": "2",
	"CATEGORIES": ["XXX"],
	"INPUTS": []
}*/

struct state {
  float x;
  float y;
  float t;
};

float x(state s) { return s.x; }
float y(state s) { return s.x; }
float t(state s) { return s.t; }

state scale(state s, float factor) {
  s.x /= factor;
  s.y /= factor;
  return s;
}

state translate(state s, float tx, float ty) {
  s.x -= tx;
  s.y -= ty;
  return s;
}

bool square(state s, float r) {
  return s.x*s.x < r*r && s.y*s.y < r*r;
}

float cos(state s, float x) {
  return cos(x);
}

//STANDARD LIB END


float scalefactor(state s) {
 return 0.100000; 
}

float redcos(state s) {
 return cos(s,x(s)) + 1.000000 / 2.000000; 
}

bool region1(state s) {
 return square(s,0.100000); 
}

bool region2(state s) {
 return region1(scale(s,0.900000)); 
}

bool region3(state s) {
 return region1(s) && !region2(s); 
}

vec4 color1(state s) {
 return vec4(redcos(scale(s,0.010000)),1.000000,1.000000,1.000000); 
}

vec4 color2(state s) {
 return region3(translate(s,0.200000,0.100000)) ? color1(s) : vec4(0.,0.,0.,1.); 
}

vec4 lammp(state s) {
 return color2(s); 
}


//MAIN FUNCTION
void main() {
  state s = state(
    (gl_FragCoord.x - RENDERSIZE.x/2.)/RENDERSIZE.x,
    (gl_FragCoord.y - RENDERSIZE.y/2.)/RENDERSIZE.x,
    TIME
  );

  gl_FragColor = lammp(s);
}
```

Dans l'ordre:
- un header ISF nécessaire, dans un commentaire GLSL (ISF est une surcouche de GLSL, qui lui-même utilise la syntaxe C)
- la "standard lib" : les fonctions standard `cos`,`square`,`scale`,`translate`,`rotate`
- le code ISF généré à partir du code Lammp (non sans origine définie, la fatigue primant sur le sens le jour où il a été nommé)
- la fonction main, qui appelle la fonction `lammp` définie dans le code généré

## Lire le code

- `lex.mll` : spécification du lexer, rien de spécial à signaler
- `parse.mly` : spécification du parser, pas très spécial non plus, on ajouté l'opérateur `:`, associatif à gauche, pour composer les transformations de gauche à droite
- `ast.ml` : définit les formes et types d'expression pour le parser
- `ast_typed.ml` : permet de générer un environnement typé en parcourant les instructions du code à compiler, qui est utilisé ensuite pour générer le code ISF
Il induit les types en les combinant ceux d'un environnement qu'il remplit progressivement, en partnat de l'environnement "standard", qui ne contient que les types des fonctions de la bibliothèque standard
- `generate.ml` : le plus dur à lire, génère le code à partir de l'AST et de l'environnement typé, il ajoute d'abord à la sortie le code de la bibliothèque standard, définis des fonctions ISF correspondant aux variables Lammp, puis crée la fonction main et appelle les fonctions générées à partir de Lammp
- `main.ml` : appelle successivement les fonctions des fichiers précédents, et gère les entrées et sortie en fonction du nombre d'arguments (0 : stdin->stdout, 1 : file->stdout, 2: file1->file2)

## Utiliser Lammp

(
- `ocamllex lex.mll`
- `ocamlyacc parse.mly`
)
- `ocamlc ast.ml ast_typed.ml parse.ml lex.ml generate.ml main.ml` 
- `./a.out example.lmp out.isf`

Pour voir le résultat, utiliser https://editor.isf.video et remplacer le code par le contenu de `out.isf`.
Encore plus facile, vous pouvez partir de l'exemple https://editor.isf.video/shaders/647cee3d454380001a9c699f, qui correpond à l'exemple fourni.