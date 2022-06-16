; da65 V2.18 - Git 28584b31
; Created:    2020-01-30 11:26:01
; Input file: original/telematic.rom
; Page:       1


.feature string_escapes
.setcpu "6502"

;----------------------------------------------------------------------
;			includes cc65
;----------------------------------------------------------------------
.feature string_escapes

.include "telestrat.inc"

;----------------------------------------------------------------------
;			includes SDK
;----------------------------------------------------------------------
.include "SDK.mac"
.include "keyboard.inc"
.include "macros/SDK-ext.mac"

; ----------------------------------------------------------------------------
;RES             := $0000
;RESB            := $0002
;DECDEB          := $0004                        ; Paramètres pour décalage
;DECFIN          := $0006                        ; Paramètres pour décalage
;DECCIB          := $0008                        ; Paramètres pour décalage
;TR0             := $000C                        ; Travail, utilisation par HyperBasic à déterminer
;TR1             := $000D                        ; Travail, utilisation par HyperBasic à déterminer
;TR5             := $0011                        ; Travail, utilisation par HyperBasic à déterminer
;TR6             := $0012                        ; Travail, utilisation par HyperBasic à déterminer
;TR7             := $0013                        ; Travail, utilisation par HyperBasic à déterminer
;DEFAFF          := $0014                        ; Caractère à afficher par défaut lors de conversion décimale (justification)
;ADSCR           := $0026                        ; Adresse début de la ligne courante écran
;SCRNB           := $0028                        ; Numéro de la fenêtre courante
VDTPAR          := $0032                        ; Travail VDT (b7: attribut G0, b6-b4: G0-G1 couleur de fond, b2: G0 soulignage)
VDTASC          := $0033                        ; Travail VDT (b7: délimiteur, b6: G1 disjoint/non disjoint, b5-b0: motif G1)
VDTATR          := $0034                        ; Travail VDT (b7: , b6: , b5: , b4: , b3: , b2-b0:)
VDTFT           := $0035                        ; Travail VDT (b7: SS2, b6: SEP)
VDTTR0          := $0036                        ; Travail VDT
VDTX            := $0038                        ; Coordonnée écran (G0-G1) colonne
VDTY            := $0039                        ; Coordonnée écran (G0-G1) ligne
VDTGX           := $003A                        ; Position code graphiqe G1: 0-1 colonne
VDTGY           := $003B                        ; Position code graphiqe G1: 0-1 colonne
FLGVD0          := $003C                        ; b7: séquence en cours, b6: ESC, b4: US, b3: REP, b1-b0: nb caractères de la séquence
FLGVD1          := $003D                        ; b7: curseur on, b6: mode graphique, b1: mode trace/efface graphique, b0:
;TIMEUS          := $0042                        ; Timer 16 bits utilisateur (secondes)
;TIMEUD          := $0044                        ; Timer 16 bits utilisateur (1/10 secondes)
;HRS1            := $004D                        ; Paramètres pour le travail sur le mode graphique
MEN             := $0060                        ; Menu, travail
MENDDX          := $0061                        ; Menu: coordonnée du 1er choix (colonne)
;MENDDY          := $0062                        ; Menu: coordonnée du 1er choix (ligne)
MENLX           := $0065                        ; Menu: longueur de la barre de choix
;ADMEN           := $0069                        ; Menu: table des choix
;VARAPL          := $00D0                        ; Pointeur pour xxx
;TABDRV          := $0208                        ; Activation des lecteurs
;FLGTEL          := $020D                        ; b7:1-> haute résolution, b6:1-> mode minitel, b5:1-> mode degrés (0->radian), b2:1->BONJOUR.COM existe, b1:1->imprimante CENTRONICS détectée, b0:1-> STRATSED absent
;TIMES           := $0211                        ; Horloge: secondes
;TIMEM           := $0212                        ; Horloge: minutes
;TIMEH           := $0213                        ; Horloge: heures
;SCRX            := $0220                        ; Coordonnée X pour chaque fenêtre
;SCRY            := $0224                        ; Coordonnée Y
;SCRDX           := $0228                        ; Début de la fenêtre
;SCRFX           := $022C                        ; Fin de la fenêtre
;SCRDY           := $0230                        ; Début de la fenêtre
;SCRFY           := $0234                        ; Fin de la fenêtre
;FLGSCR          := $0248                        ; b7: curseur visible, b6: curseur fixe, b5: video inverse, b4: 38 colonnes, b3: prochain code ESC+xx, b2: sequende US en cours, b1: douvle hauteur, b0: compteur US
;CURSCR          := $024C                        ; Caractère sous le curseur
;FLGKBD          := $0275                        ; b7: majuscules, b6: bip clavier, b5: ESC=CTRL+T, b2-b1; langue (00: QWERTY, 01: AZERTY, 10: FRENCH), b0:1 gerer les touches de fonctions
;KBDSHT          := $0278                        ; b7: CTRL, b6: FUNCT, b5: Joystick Gauche, b3: souris, b0; SHIFT
;KBDCTC          := $027E                        ; b7:1 Ctrl+C
;LPRFX           := $0288                        ; Largeur d'impression
;JCKTAB          := $029D                        ; Table des valeurs renvoyées par la souris ou le joystick
;VNMI            := $02F4                        ; Vecteur NMI (n° de banque, adresse)
VIRQ            := $02FA                        ; Vecteur IRQ
;VAPLIC          := $02FD                        ; N° banque, adresse TELEMATIC->LANGAGE
V2DRA           := $0321
;EXBNK           := $040C
;VEXBNK          := $0414
BNKCID          := $0417
L0418           := $0418                        ; Pointeur inter banques
;DRIVE           := $0500                        ; N° de lecteur
;ERRNB           := $0512                        ; Erreur Stratsed
;BUFNOM          := $0517                        ; Nom de fichier (drive+nom+extension)
;DESALO          := $052D                        ; Adresse de début du fichier
;FISALO          := $052F                        ; Adresse de fin du fichier
TAMPFC          := $0542                        ; Adresse de début des tampons fichier (initialisé à DOSBUFFERS par STARTUP)
BITMFC          := $0544                        ; (word) BitMap des tampons logiques (même convention que la BitMap disquette, 0->occupé, 1->libre))
FICNUM          := $0548                        ; Numéro logique du fichier (1 ou 2)
NBFIC           := $0549                        ; Nombre de fichiers autorisés par FILE
;BUFEDT          := $0590                        ; Buffer Editeur de Texte
BARBRE          := $4000                        ; Buffer arborescence

CODCOU		:= $7fff			; Couleur de fond
BUFTXT          := $8000                        ; Buffer code VIDEOTEX (3ko maxi)
CODDX		:= $8000			; Début de la fenêtre (X)
CODFX		:= $8001			; Fin de la fenêtre (X)
CODDY		:= $8002			; Début de la fenêter (Y)
CODFY		:= $8003			; Fin de la denêter (Y)
CODCX		:= $8004			; Position curseur (X)
CODCY		:= $8005			; Position curseur (Y)
FLGCOD		:= $8006			; Flags de la page:
						; b7: effacement de la page
						; b6: affichage du curseur
						; b5: masquage / démasquage
						; b4: codage acordéon
						; b3: inversion du sens
						; b2: codage colonne
						; b1: sens Y négatif
						; b0: sens X négatif
BUFfVDT		:= $8007			; Début des codes Videotex (terminé par un 0)

BVDTAS          := $9000                        ; Buffer attributs VDT
BVDTAT          := $9400                        ; Buffer couleur VDT
VDTDES          := $9C00                        ; Travail et conversion G2
TABDBH          := $9C80                        ; Buffer double hauteur VIDEOTEX (taille inconnue)
PAGE            := $9CC0                        ; Buffer pour le nom de la page actuelle (variable PAGE$ basic)
SCRL25          := $BF68                        ; Ecran: ligne 25
SCRL27		:= $bfb8			; Ecran: ligne 27 (statut)

; ----------------------------------------------------------------------------
XMDE = $82					; Minitel entrée
XLPR = $8e					; Imprimante sortie
XMDS = $8f					; Minitel sortie
XVDT = $91					; Videotex

XRSSBU := $18


; $A0: [ENVOI]
; $A1: [RETOUR]
; $A2: [REPETITION]
; $A3: [GUIDE]
; $A5: [SOMMAIRE]
; $A7: [SUITE]
; $A9: * [RETOUR]

MNTL_ENVOI = $a0
MNTL_RETOUR = $a1
MNTL_REPETITION = $a2
MNTL_GUIDE = $a3
MNTL_ANNULATION = $a4
MNTL_SOMMAIRE = $a5
MNTL_CORRECTION = $a6
MNTL_SUITE = $a7
MNTL_CNXFI = $a8


; ----------------------------------------------------------------------------
LE000:
        ; Vecteur NMI: LE02D banque 7
        lda     V2DRA                           ; E000 AD 21 03
        and     #$07                            ; E003 29 07
        sta     VNMI                            ; E005 8D F4 02
        lda     #<LE02D                         ; E008 A9 2D
        ldy     #>LE02D                         ; E00A A0 E0
        sta     VNMI+1                          ; E00C 8D F5 02
        sty     VNMI+2                          ; E00F 8C F6 02

        lda     #<STARTMENU                     ; E012 A9 04
        ldy     #>STARTMENU                     ; E014 A0 E2
        _XWSTR0                                 ; E016 00 14

LE018:
        ; Attend une touche
        _XRDW0                                  ; E018 00 0C

        ; 'LANGAGE'?
        cmp     #'2'                            ; E01A C9 32
        beq     LE078                           ; E01C F0 5A

        ; 'TELEMATIC'?
        cmp     #'1'                            ; E01E C9 31
        bne     LE018                           ; E020 D0 F6

        lda     #$00                            ; E022 A9 00
        sta     BARBRE                          ; E024 8D 00 40

        jsr     LEEE8                           ; E027 20 E8 EE

LE02A:
        ; Initialise le lecteur par défaut et le nom du fichier
        jsr     LE08D                           ; E02A 20 8D E0

LE02D:
        lda     #<MENU1                         ; E02D A9 30
        ldy     #>MENU1                         ; E02F A0 E2
        _XWSTR0                                 ; E031 00 14

        ldx     #$00                            ; E033 A2 00
        _XCOSCR                                 ; E035 00 34

        lda     #<LE272                         ; E037 A9 72
        ldy     #>LE272                         ; E039 A0 E2
        jsr     LE1E9                           ; E03B 20 E9 E1

        jsr     LE062                           ; E03E 20 62 E0
        jmp     LE02A                           ; E041 4C 2A E0

; ----------------------------------------------------------------------------
        .byte   $00                             ; E044 00
; Instruction Hyperbasic APLIC
;
; Entrée:
;    HRS1: 0 -> Menu principal des applications télématiques
;          1 -> Emulation Minitel
;          2 -> Edition de pages VIDEOTEX
;          3 -> Edition du serveur
;          4 -> menu de lancement du serveur
;          5 -> Reset du Telestrat (Appel à $C000 de la banque 7)
_XAPLIC:
        ; Initialise le lecteur par défaut et le nom du fichier
        jsr     LE08D                           ; E045 20 8D E0

        jsr     LEEE8                           ; E048 20 E8 EE

        ; HRS1 < 255
        lda     HRS1+1                          ; E04B A5 4E
        bne     LE0C4                           ; E04D D0 75

        ; APLIC 0?
        ldx     HRS1                            ; E04F A6 4D
        beq     LE02A                           ; E051 F0 D7

        ; HRS1 < 6?
        cpx     #$06                            ; E053 E0 06
        bcs     LE0C4                           ; E055 B0 6D

        ; Exécution de l'option choisie
        dex                                     ; E057 CA
        jsr     LE062                           ; E058 20 62 E0

	; Codes pour placer le curseur en ligne 14, colonne 0
        lda     #<LE447                         ; E05B A9 47
        ldy     #>LE447                         ; E05D A0 E4
        _XWSTR0                                 ; E05F 00 14
        rts                                     ; E061 60

; ----------------------------------------------------------------------------
LE062:
        txa                                     ; E062 8A
        ; APLIC 1 (Emulation Minitel)?
        beq     LE0D1                           ; E063 F0 6C

        ; APLIC 2 (Edition de pages VIDEOTEX)?
        dex                                     ; E065 CA
        beq     LE0A6                           ; E066 F0 3E

        ; APLIC 3 (Edition du serveur)?
        dex                                     ; E068 CA
        beq     LE08A                           ; E069 F0 1F

        ; APLIC 4 (Lancement du serveur)?
        dex                                     ; E06B CA
        bne     LE071                           ; E06C D0 03

        jmp     LE0FC                           ; E06E 4C FC E0

; ----------------------------------------------------------------------------
; APLIC 5
LE071:
        sei                                     ; E071 78
        lsr     VIRQ                            ; E072 4E FA 02
        ; Banque 7 (Telemon)
        lda     #$07                            ; E075 A9 07
        .byte   $2C                             ; E077 2C

LE078:
        ; Banque 6 (Hyperbasic)
        lda     #$06                            ; E078 A9 06

        ; Adresse: $C000
        sta     BNKCID                          ; E07A 8D 17 04
        lda     #<$C000                         ; E07D A9 00
        ldy     #>$C000                         ; E07F A0 C0
        sta     VEXBNK+1                        ; E081 8D 15 04
        sty     VEXBNK+2                        ; E084 8C 16 04
        jmp     EXBNK                           ; E087 4C 0C 04

; ----------------------------------------------------------------------------
; APLIC 3: Edition du serveur
LE08A:
        jmp     LE147                           ; E08A 4C 47 E1

; ----------------------------------------------------------------------------
; Initialise le lecteur par défaut et le nom du fichier
LE08D:
        ; Lecteur par défaut: 'A'
        lda     #$00                            ; E08D A9 00
        sta     DRIVE                           ; E08F 8D 00 05

        ; Initialise le nom de fichier: '         '
        ldx     #$09                            ; E092 A2 09
        lda     #' '                            ; E094 A9 20
LE096:
        sta     BUFNOM,x                        ; E096 9D 17 05
        dex                                     ; E099 CA
        bne     LE096                           ; E09A D0 FA

        ; /?\ ??? Un programme Hyperbasic peut aller
        ; jusqu'en BARBRE d'apès la doc
        stx     $3500                           ; E09C 8E 00 35
        stx     $3501                           ; E09F 8E 01 35

        ; /?\ Déjà fait plus haut
        stx     DRIVE                           ; E0A2 8E 00 05
        rts                                     ; E0A5 60

; ----------------------------------------------------------------------------
; APLIC 2: Edition de pages VIDEOTEX
LE0A6:
        lda     #<MENU_EDITVDT                  ; E0A6 A9 C1
        ldy     #>MENU_EDITVDT                  ; E0A8 A0 E3
        _XWSTR0                                 ; E0AA 00 14

        ; "Edition PAGES VIDEOTEX"
        lda     #<LE284                         ; E0AC A9 84
        ldy     #>LE284                         ; E0AE A0 E2
        _XWSTR0                                 ; E0B0 00 14

        lda     #<MENU_EDITSRV                  ; E0B2 A9 CA
        ldy     #>MENU_EDITSRV                  ; E0B4 A0 E3
        jsr     LE1E3                           ; E0B6 20 E3 E1

        cmp     #KEY_ESC                        ; E0B9 C9 1B
        beq     LE0C4                           ; E0BB F0 07

        ; choix "Acces disque"?
        dex                                     ; E0BD CA
        bmi     LE0C5                           ; E0BE 30 05

        ; choix "Edition" ou "Nouvelle page"?
        cpx     #$02                            ; E0C0 E0 02
        bne     LE0CB                           ; E0C2 D0 07

        ; choix "Menu principal"
LE0C4:
        rts                                     ; E0C4 60

; ----------------------------------------------------------------------------
LE0C5:
        jsr     LE131                           ; E0C5 20 31 E1
        jmp     LE0A6                           ; E0C8 4C A6 E0

; ----------------------------------------------------------------------------
; Edition PAGES VIDEOTEX
;
; Entrée:
;    X: N° du choix
;       0 -> Edition
;       1 -> Nouvelle page
LE0CB:
        jsr     LEED9                           ; E0CB 20 D9 EE
        jmp     LE0A6                           ; E0CE 4C A6 E0

; ----------------------------------------------------------------------------
; APLIC 1: Emulation Minitel
LE0D1:
        lda     #<LE40F                         ; E0D1 A9 0F
        ldy     #>LE40F                         ; E0D3 A0 E4
        _XWSTR0                                 ; E0D5 00 14

        ; "Emulation MINITEL"
        lda     #<LE272                         ; E0D7 A9 72
        ldy     #>LE272                         ; E0D9 A0 E2
        _XWSTR0                                 ; E0DB 00 14

        lda     #<MENU_EMUL                     ; E0DD A9 18
        ldy     #>MENU_EMUL                     ; E0DF A0 E4
        jsr     LE1E3                           ; E0E1 20 E3 E1

        cmp     #KEY_ESC                        ; E0E4 C9 1B
        beq     LE0EF                           ; E0E6 F0 07

        ; choix "Acces disque"?
        dex                                     ; E0E8 CA
        bmi     LE0F0                           ; E0E9 30 05

        ; choix "Emulation minitel"?
        cpx     #$01                            ; E0EB E0 01
        bne     LE0F6                           ; E0ED D0 07

        ; choix "Menu principal"
LE0EF:
        rts                                     ; E0EF 60

; ----------------------------------------------------------------------------
LE0F0:
        jsr     LE131                           ; E0F0 20 31 E1
        jmp     LE0D1                           ; E0F3 4C D1 E0

; ----------------------------------------------------------------------------
LE0F6:
        jsr     LF598                           ; E0F6 20 98 F5
        jmp     LE0D1                           ; E0F9 4C D1 E0

; ----------------------------------------------------------------------------
; APLIC 4: Lancement du serveur
LE0FC:
        lda     #<LE2D1                         ; E0FC A9 D1
        ldy     #>LE2D1                         ; E0FE A0 E2
        _XWSTR0                                 ; E100 00 14

        ; "Lancer le SERVEUR"
        lda     #<LE2AB                         ; E102 A9 AB
        ldy     #>LE2AB                         ; E104 A0 E2
        _XWSTR0                                 ; E106 00 14

	; "Acces disque"
        lda     #<LE2DA                         ; E108 A9 DA
        ldy     #>LE2DA                         ; E10A A0 E2
        jsr     LE1E3                           ; E10C 20 E3 E1

        cmp     #KEY_ESC                        ; E10F C9 1B
        beq     LE130                           ; E111 F0 1D

        ; choix "Acces disque"?
        dex                                     ; E113 CA
        bmi     LE12A                           ; E114 30 14

        ; choix "Menu principal"?
        cpx     #$04                            ; E116 E0 04
        beq     LE130                           ; E118 F0 16

        ; choix "Tester le serveur" (1), "Borne de communication" (2),
        ; "Tester sans acces disque" (3)
        ldy     TABDRV                          ; E11A AC 08 02
        beq     LE124                           ; E11D F0 05

        ldy     BARBRE                          ; E11F AC 00 40
        beq     LE0FC                           ; E122 F0 D8

LE124:
        ; A = mode de fonctionnement du serveur
        jsr     _XSERVE                         ; E124 20 A6 E4
        jmp     LE0FC                           ; E127 4C FC E0

; ----------------------------------------------------------------------------
LE12A:
        jsr     LE17F                           ; E12A 20 7F E1
        jmp     LE0FC                           ; E12D 4C FC E0

; ----------------------------------------------------------------------------
LE130:
        rts                                     ; E130 60

; ----------------------------------------------------------------------------
LE131:
        ; "PAGES VIDEOTEX"
        lda     #<VDT_NAME                      ; E131 A9 00
        ldy     #>VDT_NAME                      ; E133 A0 E4
        sta     $F6                             ; E135 85 F6
        sty     $F7                             ; E137 84 F7

        ; Initialise l'extension du fichier: 'VDT'
        ldx     #$02                            ; E139 A2 02
LE13B:
        lda     VDT_EXT,x                       ; E13B BD FD E3
        sta     BUFNOM+10,x                     ; E13E 9D 21 05
        dex                                     ; E141 CA
        bpl     LE13B                           ; E142 10 F7

        jmp     LE4A9                           ; E144 4C A9 E4

; ----------------------------------------------------------------------------
; Edition du serveur
LE147:
        ; Redéfinition de caractères
        ; Table en LE44B
        lda     #<LE44B                         ; E147 A9 4B
        ldy     #>LE44B                         ; E149 A0 E4
        _XSCRNE                                 ; E14B 00 39

LE14D:
        ;
        lda     #<LE34B                         ; E14D A9 4B
        ldy     #>LE34B                         ; E14F A0 E3
        _XWSTR0                                 ; E151 00 14

        ; 'Edition SERVEUR'
        lda     #<LE29B                         ; E153 A9 9B
        ldy     #>LE29B                         ; E155 A0 E2
        _XWSTR0                                 ; E157 00 14

	; "acces disque"
        lda     #<LE35B                         ; E159 A9 5B
        ldy     #>LE35B                         ; E15B A0 E3
        jsr     LE1E3                           ; E15D 20 E3 E1

        cmp     #KEY_ESC                        ; E160 C9 1B
        beq     LE130                           ; E162 F0 CC

        ; choix "acces disque"?
        dex                                     ; E164 CA
        bmi     LE179                           ; E165 30 12

        ; choix "menu principam"?
        cpx     #$04                            ; E167 E0 04
        beq     LE130                           ; E169 F0 C5

        ; choix "informations"?
        cpx     #$03                            ; E16B E0 03
        beq     LE19D                           ; E16D F0 2E

        ; choix "testes sans acces disque"?
        cpx     #$02                            ; E16F E0 02
        beq     LE195                           ; E171 F0 22

        ; choix "edition" ou "nouveau serveur"
        jsr     LF98A                           ; E173 20 8A F9

        jmp     LE14D                           ; E176 4C 4D E1

; ----------------------------------------------------------------------------
LE179:
        jsr     LE17F                           ; E179 20 7F E1
        jmp     LE14D                           ; E17C 4C 4D E1

; ----------------------------------------------------------------------------
LE17F:
        ; "SERVEUR"
        lda     #<SRV_NAME                      ; E17F A9 B9
        ldy     #>SRV_NAME                      ; E181 A0 E3
        sta     $F6                             ; E183 85 F6
        sty     $F7                             ; E185 84 F7

        ; Place l'extension "SRV" dans BUFNOM
        ldx     #$02                            ; E187 A2 02
LE189:
        lda     SRV_EXT,x                       ; E189 BD B6 E3
        sta     BUFNOM+10,x                     ; E18C 9D 21 05
        dex                                     ; E18F CA
        bpl     LE189                           ; E190 10 F7

        jmp     LE4A9                           ; E192 4C A9 E4

; ----------------------------------------------------------------------------
LE195:
        ; Mode du serveur: "Tester sans acces disque"
        ldx     #$03                            ; E195 A2 03
        jsr     _XSERVE                         ; E197 20 A6 E4

        jmp     LE14D                           ; E19A 4C 4D E1

; ----------------------------------------------------------------------------
; Calcule et affiche le nombre de pages de l'arborescence
LE19D:
        ; Efface l'écran
        lda     #$0C                            ; E19D A9 0C
        _XWR0                                   ; E19F 00 10

        ; RES := BARBRE
        lda     #<BARBRE                        ; E1A1 A9 00
        ldy     #>BARBRE                        ; E1A3 A0 40
        sta     RES                             ; E1A5 85 00
        sty     RES+1                           ; E1A7 84 01

        ; nombre de pages := 0
        ldy     #$00                            ; E1A9 A0 00
        sty     RESB                            ; E1AB 84 02
        sty     RESB+1                          ; E1AD 84 03

LE1AF:
        ; Fin de l'arborescence atteinte?
        lda     (RES),y                         ; E1AF B1 00
        beq     LE1C8                           ; E1B1 F0 15

        ; Longueur ==1?
        ; (page vide)
        cmp     #$01                            ; E1B3 C9 01
        beq     LE1BD                           ; E1B5 F0 06

        ; Non, incrémente le nombre de pages
        inc     RESB                            ; E1B7 E6 02
        bne     LE1BD                           ; E1B9 D0 02
        inc     RESB+1                          ; E1BB E6 03

LE1BD:
        ; Passe à la page suivante
        clc                                     ; E1BD 18
        adc     RES                             ; E1BE 65 00
        sta     RES                             ; E1C0 85 00
        bcc     LE1AF                           ; E1C2 90 EB
        inc     RES+1                           ; E1C4 E6 01
        bcs     LE1AF                           ; E1C6 B0 E7

LE1C8:
        ; Conversion du nombre de pages en chaine
        ; et affichage
        lda     RESB                            ; E1C8 A5 02
        ldy     RESB+1                          ; E1CA A4 03
        jsr     LE1DA                           ; E1CC 20 DA E1

        ; " pages"
        lda     #<LE354                         ; E1CF A9 54
        ldy     #>LE354                         ; E1D1 A0 E3
        _XWSTR0                                 ; E1D3 00 14

        ; Attend une touche
        _XRDW0                                  ; E1D5 00 0C

        jmp     LE147                           ; E1D7 4C 47 E1

; ----------------------------------------------------------------------------
; Converti AY en chaine et l'affiche
; (justification à gauche avec des ' ')
LE1DA:
        ldx     #' '                            ; E1DA A2 20
        stx     DEFAFF                          ; E1DC 86 14
        ldx     #$02                            ; E1DE A2 02
        _XDECIM                                 ; E1E0 00 29
        rts                                     ; E1E2 60

; ----------------------------------------------------------------------------
LE1E3:
        pha                                     ; E1E3 48

        lda     #$04                            ; E1E4 A9 04
        _XWR0                                   ; E1E6 00 10

        pla                                     ; E1E8 68

        ; ----------------------------------------------------------------------------
        ; Affiche un menu (appel direct uniquement pour le menu principal)
        ;
        ; Force le n° de ligne du début de la fenêtre: 6
        ;
LE1E9:
        ldx     #$06                            ; E1E9 A2 06

        ; ----------------------------------------------------------------------------
        ; Affiche un menu
        ;
        ; Entrée:
        ;    AY: Adresse du menu
        ;     X: N° de la ligne du début de la fenêtre menuu
        ;
        ; Sortie:
        ;     A: Touche de sortie du menu (KEY_RETURN,KEY_ESC, KEY_SPACE)
        ;     X: n° du choix
LE1EB:
        stx     MENDDY                          ; E1EB 86 62
        sta     ADMEN                           ; E1ED 85 69
        sty     ADMEN+1                         ; E1EF 84 6A

        ; Largeur de la barre de choix: 36
        ldx     #$24                            ; E1F1 A2 24
        stx     MENLX                           ; E1F3 86 65

        ; Colonne du début de la fenêtre menu: 2
        ldx     #$02                            ; E1F5 A2 02
        stx     MENDDX                          ; E1F7 86 61

        lda     #$00                            ; E1F9 A9 00
        tay                                     ; E1FB A8

        ldx     #$16                            ; E1FC A2 16
        _XMENU                                  ; E1FE 00 2C

        asl     KBDCTC                          ; E200 0E 7E 02
        rts                                     ; E203 60

; ----------------------------------------------------------------------------
;                         Menus de l'application
; ----------------------------------------------------------------------------
;
STARTMENU:
        .byte   $0A,$0D                         ; E204 0A 0D
        .byte   " 1- TELEMATIC"                 ; E206 20 31 2D 20 54 45 4C 45
                                                ; E20E 4D 41 54 49 43
        .byte   $0D,$0A                         ; E213 0D 0A
        .byte   " 2- LANGAGE"                   ; E215 20 32 2D 20 4C 41 4E 47
                                                ; E21D 41 47 45
        .byte   $0D,$0A,$0A                     ; E220 0D 0A 0A
        .byte   "Votre choix:"                  ; E223 56 6F 74 72 65 20 63 68
                                                ; E22B 6F 69 78 3A
        .byte   $00                             ; E22F 00
MENU1:
        .byte   $0C,$0A,$04,$94,$8A,$1F         ; E230 0C 0A 04 94 8A 1F
        .byte   "BMTELEMATIC V2.0b"             ; E236 42 4D 54 45 4C 45 4D 41
                                                ; E23E 54 49 43 20 56 32 2E 30
                                                ; E246 62
        .byte   $04,$0D,$0A,$0A,$1F             ; E247 04 0D 0A 0A 1F
        .byte   "DB"                            ; E24C 44 42
        .byte   $86                             ; E24E 86
        .byte   "Conception & realisation: F.BRO"; E24F 43 6F 6E 63 65 70 74 69
                                                ; E257 6F 6E 20 26 20 72 65 61
                                                ; E25F 6C 69 73 61 74 69 6F 6E
                                                ; E267 3A 20 46 2E 42 52 4F
        .byte   "CHE"                           ; E26E 43 48 45
        .byte   $00                             ; E271 00

LE272:
        .byte   "Emulation MINITEL"             ; E272 45 6D 75 6C 61 74 69 6F
                                                ; E27A 6E 20 4D 49 4E 49 54 45
                                                ; E282 4C
        .byte   $00                             ; E283 00
LE284:
        .byte   "Edition PAGES VIDEOTEX"        ; E284 45 64 69 74 69 6F 6E 20
                                                ; E28C 50 41 47 45 53 20 56 49
                                                ; E294 44 45 4F 54 45 58
        .byte   $00                             ; E29A 00
LE29B:
        .byte   "Edition SERVEUR"               ; E29B 45 64 69 74 69 6F 6E 20
                                                ; E2A3 53 45 52 56 45 55 52
        .byte   $00                             ; E2AA 00
LE2AB:
        .byte   "Lancer le SERVEUR"             ; E2AB 4C 61 6E 63 65 72 20 6C
                                                ; E2B3 65 20 53 45 52 56 45 55
                                                ; E2BB 52
        .byte   $00                             ; E2BC 00
        .byte   "Relancer TELESTRAT"            ; E2BD 52 65 6C 61 6E 63 65 72
                                                ; E2C5 20 54 45 4C 45 53 54 52
                                                ; E2CD 41 54
        .byte   $00,$00                         ; E2CF 00 00


LE2D1:
        .byte   $0C,$0A,$04,$94,$8A,$1F         ; E2D1 0C 0A 04 94 8A 1F
        .byte   "BK"                            ; E2D7 42 4B
        .byte   $00                             ; E2D9 00

LE2DA:
        .byte   "Acces disque"                  ; E2DA 41 63 63 65 73 20 64 69
                                                ; E2E2 73 71 75 65
        .byte   $00                             ; E2E6 00
        .byte   "Lancer le serveur"             ; E2E7 4C 61 6E 63 65 72 20 6C
                                                ; E2EF 65 20 73 65 72 76 65 75
                                                ; E2F7 72
        .byte   $00                             ; E2F8 00
        .byte   "Tester le serveur"             ; E2F9 54 65 73 74 65 72 20 6C
                                                ; E301 65 20 73 65 72 76 65 75
                                                ; E309 72
        .byte   $00                             ; E30A 00
        .byte   "Borne de communication"        ; E30B 42 6F 72 6E 65 20 64 65
                                                ; E313 20 63 6F 6D 6D 75 6E 69
                                                ; E31B 63 61 74 69 6F 6E
        .byte   $00                             ; E321 00
        .byte   "Tester sans acces disque"      ; E322 54 65 73 74 65 72 20 73
                                                ; E32A 61 6E 73 20 61 63 63 65
                                                ; E332 73 20 64 69 73 71 75 65
        .byte   $00                             ; E33A 00
        .byte   "Menu principal"                ; E33B 4D 65 6E 75 20 70 72 69
                                                ; E343 6E 63 69 70 61 6C
        .byte   $00,$00                         ; E349 00 00


LE34B:
        .byte   $0C,$0A,$04,$94,$8A,$1F         ; E34B 0C 0A 04 94 8A 1F
        .byte   "BL"                            ; E351 42 4C
        .byte   $00                             ; E353 00

LE354:
        .byte   " pages"                        ; E354 20 70 61 67 65 73
        .byte   $00                             ; E35A 00
LE35B:
        .byte   "acces disque"                  ; E35B 61 63 63 65 73 20 64 69
                                                ; E363 73 71 75 65
        .byte   $00                             ; E367 00
        .byte   "edition"                       ; E368 65 64 69 74 69 6F 6E
        .byte   $00                             ; E36F 00
        .byte   "nouveau serveur"               ; E370 6E 6F 75 76 65 61 75 20
                                                ; E378 73 65 72 76 65 75 72
        .byte   $00                             ; E37F 00
        .byte   "tester sans acces disque"      ; E380 74 65 73 74 65 72 20 73
                                                ; E388 61 6E 73 20 61 63 63 65
                                                ; E390 73 20 64 69 73 71 75 65
        .byte   $00                             ; E398 00
        .byte   "informations"                  ; E399 69 6E 66 6F 72 6D 61 74
                                                ; E3A1 69 6F 6E 73
        .byte   $00                             ; E3A5 00
        .byte   "menu principal"                ; E3A6 6D 65 6E 75 20 70 72 69
                                                ; E3AE 6E 63 69 70 61 6C
        .byte   $00,$00                         ; E3B4 00 00

SRV_EXT:
        .byte   "SRV"                           ; E3B6 53 52 56

SRV_NAME:
        .byte   "SERVEUR"                       ; E3B9 53 45 52 56 45 55 52
        .byte   $00                             ; E3C0 00

MENU_EDITVDT:
        .byte   $0C,$0A,$04,$94,$8A,$1F         ; E3C1 0C 0A 04 94 8A 1F
        .byte   "BI"                            ; E3C7 42 49
        .byte   $00                             ; E3C9 00
MENU_EDITSRV:
        .byte   "Acces disque"                  ; E3CA 41 63 63 65 73 20 64 69
                                                ; E3D2 73 71 75 65
        .byte   $00                             ; E3D6 00
        .byte   "Edition"                       ; E3D7 45 64 69 74 69 6F 6E
        .byte   $00                             ; E3DE 00
        .byte   "Nouvelle page"                 ; E3DF 4E 6F 75 76 65 6C 6C 65
                                                ; E3E7 20 70 61 67 65
        .byte   $00                             ; E3EC 00
        .byte   "Menu principal"                ; E3ED 4D 65 6E 75 20 70 72 69
                                                ; E3F5 6E 63 69 70 61 6C
        .byte   $00,$00                         ; E3FB 00 00

VDT_EXT:
        .byte   "VDT"                           ; E3FD 56 44 54

VDT_NAME:
        .byte   "PAGES VIDEOTEX"                ; E400 50 41 47 45 53 20 56 49
                                                ; E408 44 45 4F 54 45 58
        .byte   $00                             ; E40E 00

LE40F:
        .byte   $0C,$0A,$04,$94,$8A,$1F         ; E40F 0C 0A 04 94 8A 1F
        .byte   "BK"                            ; E415 42 4B
        .byte   $00                             ; E417 00

MENU_EMUL:
        .byte   "Acces disque"                  ; E418 41 63 63 65 73 20 64 69
                                                ; E420 73 71 75 65
        .byte   $00                             ; E424 00
        .byte   "Emulation minitel"             ; E425 45 6D 75 6C 61 74 69 6F
                                                ; E42D 6E 20 6D 69 6E 69 74 65
                                                ; E435 6C
        .byte   $00                             ; E436 00
        .byte   "Menu principal"                ; E437 4D 65 6E 75 20 70 72 69
                                                ; E43F 6E 63 69 70 61 6C
        .byte   $00,$00                         ; E445 00 00
; ----------------------------------------------------------------------------
; Codes pour placer le curseur en ligne 14, colonne 0
LE447:
        .byte   $1F,$4E,$40,$00                 ; E447 1F 4E 40 00

; Table de redéfinition de caractères
; <code ASCII>, 8 octets pour la définition,...
LE44B:
        .byte   $A0,$00,$00,$00,$00,$00,$00,$00 ; E44B A0 00 00 00 00 00 00 00
        .byte   $00,$E0,$0C,$0C,$0C,$0C,$0C,$0C ; E453 00 E0 0C 0C 0C 0C 0C 0C
        .byte   $0C,$00,$E5,$00,$00,$00,$3F,$3F ; E45B 0C 00 E5 00 00 00 3F 3F
        .byte   $00,$00,$00,$E1,$00,$00,$00,$03 ; E463 00 00 00 E1 00 00 00 03
        .byte   $07,$0C,$0C,$00,$E2,$00,$00,$00 ; E46B 07 0C 0C 00 E2 00 00 00
        .byte   $30,$38,$0C,$0C,$00,$E3,$0C,$0C ; E473 30 38 0C 0C 00 E3 0C 0C
        .byte   $0C,$3F,$3F,$00,$00,$00,$E4,$00 ; E47B 0C 3F 3F 00 00 00 E4 00
        .byte   $00,$00,$3F,$3F,$0C,$0C,$00,$E6 ; E483 00 00 3F 3F 0C 0C 00 E6
        .byte   $0C,$0C,$0C,$3C,$3C,$0C,$0C,$00 ; E48B 0C 0C 0C 3C 3C 0C 0C 00
        .byte   $E7,$0C,$0C,$0C,$0F,$0F,$0C,$0C ; E493 E7 0C 0C 0C 0F 0F 0C 0C
        .byte   $00,$E8,$0C,$0C,$0C,$3F,$3F,$0C ; E49B 00 E8 0C 0C 0C 3F 3F 0C
        .byte   $0C,$00,$00                     ; E4A3 0C 00 00
; ----------------------------------------------------------------------------
; Instruction Hyperbasic SERVEUR
_XSERVE:
        jmp     _SERVEUR                        ; E4A6 4C C7 E9

; ----------------------------------------------------------------------------
LE4A9:
        _XCOSCR                                 ; E4A9 00 34
        lda     #$00                            ; E4AB A9 00
        sta     BUFNOM                          ; E4AD 8D 17 05

        ; "ACCES DISQUE:"
        lda     #<LE62F                         ; E4B0 A9 2F
        ldy     #>LE62F                         ; E4B2 A0 E6
        _XWSTR0                                 ; E4B4 00 14

        ; Affiche le type d'accès ("PAGES VIDEOTEX",...)
        lda     $F6                             ; E4B6 A5 F6
        ldy     $F7                             ; E4B8 A4 F7
        _XWSTR0                                 ; E4BA 00 14

        ; Affiche les différentes options possibles
        lda     #<LE645                         ; E4BC A9 45
        ldy     #>LE645                         ; E4BE A0 E6
        _XWSTR0                                 ; E4C0 00 14

        ; Affiche "Nom courant:"+nom actuel du fichier
        jsr     LE5CD                           ; E4C2 20 CD E5

LE4C5:
        lda     #$1E                            ; E4C5 A9 1E
        _XWR0                                   ; E4C7 00 10

        ldx     SCRNB                           ; E4C9 A6 28
        _XCSSCR                                 ; E4CB 00 35

        ; Attend une touche
        _XRDW0                                  ; E4CD 00 0C

        ; CTRL+C? -> LE4D8
        asl     KBDCTC                          ; E4CF 0E 7E 02
        bcs     LE4D8                           ; E4D2 B0 04

        cmp     #KEY_ESC                        ; E4D4 C9 1B
        bne     LE4DD                           ; E4D6 D0 05

LE4D8:
        ldx     #$00                            ; E4D8 A2 00
        _XCOSCR                                 ; E4DA 00 34
        rts                                     ; E4DC 60

; ----------------------------------------------------------------------------
LE4DD:
        ; < 'A'? -> LE4F4
        ; /?\ pourquoi pas directement bcc LE4C5 ???
        cmp     #'A'                            ; E4DD C9 41
        bcc     LE4F4                           ; E4DF 90 13

        ; 'E'crire?
        cmp     #'E'                            ; E4E1 C9 45
        beq     LE500                           ; E4E3 F0 1B

        ; > E'?
        bcs     LE4F4                           ; E4E5 B0 0D

        ; Ici, sélection du lecteur: 'A','B','C,'D'
        sbc     #'A'-1                          ; E4E7 E9 40
        sta     DRIVE                           ; E4E9 8D 00 05

        ; Exécute une fonction STRATSED si il est présent (affiche une erreur si pas de STRATSED)
        ; A = XFFBC
        lda     #$BC                            ; E4EC A9 BC
        jsr     LE5E2                           ; E4EE 20 E2 E5

        jmp     LE4A9                           ; E4F1 4C A9 E4

; ----------------------------------------------------------------------------
LE4F4:
        ; 'L'ire?
        cmp     #'L'                            ; E4F4 C9 4C
        bne     LE508                           ; E4F6 D0 10

LE4F8:
        ; Exécute une fonction STRATSED si il est présent (affiche une erreur si pas de STRATSED)
        ; A = XFFC5
        lda     #$C5                            ; E4F8 A9 C5
        jsr     LE5E2                           ; E4FA 20 E2 E5

        jmp     LE4A9                           ; E4FD 4C A9 E4

; ----------------------------------------------------------------------------
LE500:
        ; Exécute une fonction STRATSED si il est présent (affiche une erreur si pas de STRATSED)
        ; A = XFFC2
        lda     #$C2                            ; E500 A9 C2
        jsr     LE5E2                           ; E502 20 E2 E5

        jmp     LE4A9                           ; E505 4C A9 E4

; ----------------------------------------------------------------------------
LE508:
        ; 'N'ommer?
        cmp     #'N'                            ; E508 C9 4E
        bne     LE560                           ; E50A D0 54

        ; Initialise BUFNOM := '        '
        lda     #' '                            ; E50C A9 20
        ldx     #$09                            ; E50E A2 09
LE510:
        sta     BUFNOM,x                        ; E510 9D 17 05
        dex                                     ; E513 CA
        bne     LE510                           ; E514 D0 FA

        ; Affiche "Nom courant:" en ligne 5, colonne 1
        lda     #<LE6B2                         ; E516 A9 B2
        ldy     #>LE6B2                         ; E518 A0 E6
        _XWSTR0                                 ; E51A 00 14

        ldx     #$00                            ; E51C A2 00
LE51E:
        ; Attend une touche
        _XRDW0                                  ; E51E 00 0C

        ; [DELETE]?
        cmp     #KEY_DEL                        ; E520 C9 7F
        bne     LE52F                           ; E522 D0 0B

        ; saisie vide?
        txa                                     ; E524 8A
        beq     LE51E                           ; E525 F0 F7

        ; Décrémente le nombre de caractère de la saisie
        dex                                     ; E527 CA

        ; 'affiche' un BS
        lda     #$08                            ; E528 A9 08
        _XWR0                                   ; E52A 00 10

        jmp     LE51E                           ; E52C 4C 1E E5

; ----------------------------------------------------------------------------
LE52F:
        cmp     #KEY_RETURN                     ; E52F C9 0D
        beq     LE55D                           ; E531 F0 2A

        ; CTRL+E ('E'crire)?
        cmp     #KEY_CTRL_E                     ; E533 C9 05
        beq     LE500                           ; E535 F0 C9

        ; CTRL+L ('L'ire)?
        cmp     #KEY_CTRL_L                     ; E537 C9 0C
        beq     LE4F8                           ; E539 F0 BD

        cmp     #' '                            ; E53B C9 20
        beq     LE553                           ; E53D F0 14

        ; Le premier caractère du nom ne peut être un chiffre
        cpx     #$00                            ; E53F E0 00
        beq     LE54B                           ; E541 F0 08

        ; Caractère numérique?
        cmp     #'0'                            ; E543 C9 30
        bcc     LE51E                           ; E545 90 D7
        cmp     #'9'+1                          ; E547 C9 3A
        bcc     LE553                           ; E549 90 08

LE54B:
        ; Caractère alpha?
        cmp     #'A'                            ; E54B C9 41
        bcc     LE51E                           ; E54D 90 CF
        cmp     #'Z'+1                          ; E54F C9 5B
        bcs     LE51E                           ; E551 B0 CB

LE553:
        ; Affiche le caractère
        _XWR0                                   ; E553 00 10

        ; Ajoute le caractère à BUFNOM
        ; Sortie si on a saisi 8 caractères
        sta     BUFNOM+1,x                      ; E555 9D 18 05
        inx                                     ; E558 E8
        cpx     #$07                            ; E559 E0 07
        bne     LE51E                           ; E55B D0 C1

LE55D:
        jmp     LE4C5                           ; E55D 4C C5 E4

; ----------------------------------------------------------------------------
LE560:
        ; 'I'nitialiser?
        cmp     #'I'                            ; E560 C9 49
        bne     LE56F                           ; E562 D0 0B

        ; A = XFFBF
        lda     #$BF                            ; E564 A9 BF
        .byte   $2C                             ; E566 2C

LE567:
        ; A = XFFB0
        lda     #$B0                            ; E567 A9 B0

        ; Exécute une fonction STRATSED si il est présent (affiche une erreur si pas de STRATSED)
        jsr     LE5E2                           ; E569 20 E2 E5
        jmp     LE4A9                           ; E56C 4C A9 E4

; ----------------------------------------------------------------------------
LE56F:
        ; D'u'pliquer?
        cmp     #'U'                            ; E56F C9 55
        beq     LE567                           ; E571 F0 F4

        ; 'M'enage?
        cmp     #'M'                            ; E573 C9 4D
        bne     LE585                           ; E575 D0 0E

        ; A = XFFAD
        lda     #$AD                            ; E577 A9 AD
        .byte   $2C                             ; E579 2C

LE57A:
        ; A = XFFB6
        lda     #$B6                            ; E57A A9 B6
        .byte   $2C                             ; E57C 2C

LE57D:
        ; A = XFFB3
        lda     #$B3                            ; E57D A9 B3

        ; Exécute une fonction STRATSED si il est présent (affiche une erreur si pas de STRATSED)
        jsr     LE5E2                           ; E57F 20 E2 E5

        jmp     LE4A9                           ; E582 4C A9 E4

; ----------------------------------------------------------------------------
LE585:
        ; 'DeT'ruire?
        cmp     #'T'                            ; E585 C9 54
        beq     LE57A                           ; E587 F0 F1

        ; 'R'ecuperer?
        cmp     #'R'                            ; E589 C9 52
        beq     LE57D                           ; E58B F0 F0

        ; 'S'electionner?
        cmp     #'S'                            ; E58D C9 53
        bne     LE5CA                           ; E58F D0 39

        lda     #$00                            ; E591 A9 00
        sta     FLGSCR                          ; E593 8D 48 02

        ldx     #$0B                            ; E596 A2 0B
        lda     #$00                            ; E598 A9 00
        ldy     #$35                            ; E59A A0 35
        jsr     LE1EB                           ; E59C 20 EB E1

        cmp     #KEY_ESC                        ; E59F C9 1B
        beq     LE5CA                           ; E5A1 F0 27

        inx                                     ; E5A3 E8
        lda     #$FF                            ; E5A4 A9 FF
        ldy     #$34                            ; E5A6 A0 34
        sta     RES                             ; E5A8 85 00
        sty     RES+1                           ; E5AA 84 01
        ldy     #$00                            ; E5AC A0 00
LE5AE:
        dex                                     ; E5AE CA
        beq     LE5BD                           ; E5AF F0 0C

LE5B1:
        inc     RES                             ; E5B1 E6 00
        bne     LE5B7                           ; E5B3 D0 02
        inc     RES+1                           ; E5B5 E6 01

LE5B7:
        lda     (RES),y                         ; E5B7 B1 00
        bne     LE5B1                           ; E5B9 D0 F6
        beq     LE5AE                           ; E5BB F0 F1

LE5BD:
        iny                                     ; E5BD C8
        lda     (RES),y                         ; E5BE B1 00
        sta     BUFNOM,y                        ; E5C0 99 17 05
        cpy     #$07                            ; E5C3 C0 07
        bne     LE5BD                           ; E5C5 D0 F6

        ; Affiche "Nom courant:"+nom actuel du fichier
        jsr     LE5CD                           ; E5C7 20 CD E5

LE5CA:
        jmp     LE4C5                           ; E5CA 4C C5 E4

; ----------------------------------------------------------------------------
; Affiche "Nom courant:"+nom actuel du fichier
LE5CD:
        ; Affiche "Nom courant:" en ligne 5, colonne 1
        lda     #<LE6B2                         ; E5CD A9 B2
        ldy     #>LE6B2                         ; E5CF A0 E6
        _XWSTR0                                 ; E5D1 00 14

        ; Affiche le nom actuel du fichier
        ldx     #$F8                            ; E5D3 A2 F8
LE5D5:
        lda     BUFNOM+1-$F8,x                  ; E5D5 BD 20 04
        _XWR0                                   ; E5D8 00 10
        inx                                     ; E5DA E8
        bne     LE5D5                           ; E5DB D0 F8

        tax                                     ; E5DD AA
        rts                                     ; E5DE 60

; ----------------------------------------------------------------------------
        plp                                     ; E5DF 28
        tax                                     ; E5E0 AA
        rts                                     ; E5E1 60

; ----------------------------------------------------------------------------
; Exécute une fonction STRATSED si il est présent (affiche une erreur si pas de STRATSED)
;
; Entrée:
;    A: Poids faible pour VEXBNK
;
; Sortie:
;    A: ERRNB
;    X: 1 -> STRATSED absent
LE5E2:
        pha                                     ; E5E2 48

        ; Positionne le curseur en ligne 23, colonne 1
        lda     #<LE6DC                         ; E5E3 A9 DC
        ldy     #>LE6DC                         ; E5E5 A0 E6
        _XWSTR0                                 ; E5E7 00 14

        pla                                     ; E5E9 68

        clc                                     ; E5EA 18
        ; Masque l'instruction suivante
        .byte   $24                             ; E5EB 24

; Exécute une fonction STRATSED si il est présent (n'affiche pas d'erreur si pas de STRATSED)
;
; Entrée:
;    A: Poids faible pour VEXBNK
;
; Sortie:
;    A: ERRNB
;    X: 1 -> STRATSED absent
LE5EC:
        sec                                     ; E5EC 38

        ; Sauvegarde P pour plus tard
        php                                     ; E5ED 08

        sta     VEXBNK+1                        ; E5EE 8D 15 04

        ; Stratsed présent? oui -> LE60B
        lda     FLGTEL                          ; E5F1 AD 0D 02
        lsr     a                               ; E5F4 4A
        bcc     LE60B                           ; E5F5 90 14

        ; Restaure P
        ; C=1? -> Fin
        plp                                     ; E5F7 28
        bcs     LE608                           ; E5F8 B0 0E

        ; Affiche "STRATSED absent!" en ligne 0, colonne 1
        lda     #<LE6C3                         ; E5FA A9 C3
        ldy     #>LE6C3                         ; E5FC A0 E6
        _XWSTR0                                 ; E5FE 00 14

        ; Attend l'appui sur une touche
        _XRDW0                                  ; E600 00 0C

        ; Efface la ligne suivante
        lda     #<LE6D8                         ; E602 A9 D8
        ldy     #>LE6D8                         ; E604 A0 E6
        _XWSTR0                                 ; E606 00 14

LE608:
        ldx     #$01                            ; E608 A2 01
        rts                                     ; E60A 60

; ----------------------------------------------------------------------------
; Appel d'une fonction STRATSED
; Entrée:
;    P:
;    VEXBNK+1: déjà renseigner avec le poids faible de la fonction
;
; Sortie:
;    A: code erreur STRATSED
LE60B:
        ; Appel VEXBNK dans la banque 0 (STRATSED)
        lda     #$FF                            ; E60B A9 FF
        sta     VEXBNK+2                        ; E60D 8D 16 04
        lda     #$00                            ; E610 A9 00
        sta     BNKCID                          ; E612 8D 17 04
        ; Restaure P ((sauvegardé en LE5ED)
        plp                                     ; E615 28
        jsr     EXBNK                           ; E616 20 0C 04

        ; Restaure le vecteur d'erreur
        lda     #<XERVEC                        ; E619 A9 32
        ldy     #>XERVEC                        ; E61B A0 FF
        sta     VEXBNK+1                        ; E61D 8D 15 04
        sty     VEXBNK+2                        ; E620 8C 16 04
        lda     #$00                            ; E623 A9 00
        sta     BNKCID                          ; E625 8D 17 04
        jsr     EXBNK                           ; E628 20 0C 04

        ; Récupère le code d'erreur STRATSED
        lda     ERRNB                           ; E62B AD 12 05
        rts                                     ; E62E 60

; ----------------------------------------------------------------------------
LE62F:
        .byte   $0C,$0A,$04,$94,$8A,$1F         ; E62F 0C 0A 04 94 8A 1F
        .byte   "BHACCES DISQUE:"               ; E635 42 48 41 43 43 45 53 20
                                                ; E63D 44 49 53 51 55 45 3A
        .byte   $00                             ; E644 00
LE645:
        .byte   $04,$0D,$0A,$0A,$0A,$1F         ; E645 04 0D 0A 0A 0A 1F
        .byte   "GFLecteur "                    ; E64B 47 46 4C 65 63 74 65 75
                                                ; E653 72 20
        .byte   $C1                             ; E655 C1
        .byte   " "                             ; E656 20
        .byte   $C2                             ; E657 C2
        .byte   " "                             ; E658 20
        .byte   $C3                             ; E659 C3
        .byte   " "                             ; E65A 20
        .byte   $C4                             ; E65B C4
        .byte   "  "                            ; E65C 20 20
        .byte   $C9                             ; E65E C9
        .byte   "nitialiser"                    ; E65F 6E 69 74 69 61 6C 69 73
                                                ; E667 65 72
        .byte   $1F                             ; E669 1F
        .byte   "HE"                            ; E66A 48 45
        .byte   $CC                             ; E66C CC
        .byte   "ire "                          ; E66D 69 72 65 20
        .byte   $C5                             ; E671 C5
        .byte   "crire "                        ; E672 63 72 69 72 65 20
        .byte   $D3                             ; E678 D3
        .byte   "electionner "                  ; E679 65 6C 65 63 74 69 6F 6E
                                                ; E681 6E 65 72 20
        .byte   $CE                             ; E685 CE
        .byte   "ommer"                         ; E686 6F 6D 6D 65 72
        .byte   $1F                             ; E68B 1F
        .byte   "ICDe"                          ; E68C 49 43 44 65
        .byte   $D4                             ; E690 D4
        .byte   "ruire D"                       ; E691 72 75 69 72 65 20 44
        .byte   $F5                             ; E698 F5
        .byte   "pliquer "                      ; E699 70 6C 69 71 75 65 72 20
        .byte   $D2                             ; E6A1 D2
        .byte   "ecuperer "                     ; E6A2 65 63 75 70 65 72 65 72
                                                ; E6AA 20
        .byte   $CD                             ; E6AB CD
        .byte   "enage"                         ; E6AC 65 6E 61 67 65
        .byte   $00                             ; E6B1 00

LE6B2:
        .byte   $1F                             ; E6B2 1F
        .byte   "EANom courant:"                ; E6B3 45 41 4E 6F 6D 20 63 6F
                                                ; E6BB 75 72 61 6E 74 3A
        .byte   $18,$00                         ; E6C1 18 00

LE6C3:
        .byte   $1F                             ; E6C3 1F
        .byte   "@ASTRATSED absent !"           ; E6C4 40 41 53 54 52 41 54 53
                                                ; E6CC 45 44 20 61 62 73 65 6E
                                                ; E6D4 74 20 21
        .byte   $00                             ; E6D7 00

LE6D8:
        .byte   $0D,$18,$0A,$00                 ; E6D8 0D 18 0A 00

LE6DC:
        .byte   $1F                             ; E6DC 1F
        .byte   "WA"                            ; E6DD 57 41
        .byte   $00                             ; E6DF 00

LE6E0:
        .byte   $14,$1F                         ; E6E0 14 1F
        .byte   "@A"                            ; E6E2 40 41
        .byte   $18,$0C,$1B                     ; E6E4 18 0C 1B
        .byte   "S "                            ; E6E7 53 20
        .byte   $1B                             ; E6E9 1B
        .byte   "@ serveur "                    ; E6EA 40 20 73 65 72 76 65 75
                                                ; E6F2 72 20
        .byte   $1B                             ; E6F4 1B
        .byte   "NTELESTRAT"                    ; E6F5 4E 54 45 4C 45 53 54 52
                                                ; E6FD 41 54
        .byte   $1B                             ; E6FF 1B
        .byte   "L (c) ORIC"                    ; E700 4C 20 28 63 29 20 4F 52
                                                ; E708 49 43
        .byte   $18,$00                         ; E70A 18 00

LE70C:
        .byte   $0C                             ; E70C 0C
        .byte   "Attent"                        ; E70D 41 74 74 65 6E 74
LE713:
        .byte   "e de communication"            ; E713 65 20 64 65 20 63 6F 6D
                                                ; E71B 6D 75 6E 69 63 61 74 69
                                                ; E723 6F 6E
        .byte   $0A,$0D,$00                     ; E725 0A 0D 00

LE728:
        .byte   $0C                             ; E728 0C
        .byte   "Debut d'emission"              ; E729 44 65 62 75 74 20 64 27
                                                ; E731 65 6D 69 73 73 69 6F 6E
        .byte   $0A,$0D,$00                     ; E739 0A 0D 00

LE73C:
        .byte   $0A                             ; E73C 0A
        .byte   "Attente connexion du correspond"; E73D 41 74 74 65 6E 74 65 20
                                                ; E745 63 6F 6E 6E 65 78 69 6F
                                                ; E74D 6E 20 64 75 20 63 6F 72
                                                ; E755 72 65 73 70 6F 6E 64
        .byte   "ant"                           ; E75C 61 6E 74
        .byte   $0A,$0D,$00                     ; E75F 0A 0D 00

LE762:
        .byte   $0D,$0A                         ; E762 0D 0A
        .byte   "Emission de la page "          ; E764 45 6D 69 73 73 69 6F 6E
                                                ; E76C 20 64 65 20 6C 61 20 70
                                                ; E774 61 67 65 20
        .byte   $22,$00                         ; E778 22 00

LE77A:
        .byte   $22                             ; E77A 22
LE77B:
        .byte   $0D,$0A                         ; E77B 0D 0A
        .byte   ">"                             ; E77D 3E
        .byte   $00                             ; E77E 00

LE77F:
        .byte   $0C,$1F                         ; E77F 0C 1F
        .byte   "SAMot cle:"                    ; E781 53 41 4D 6F 74 20 63 6C
                                                ; E789 65 3A
        .byte   $00                             ; E78B 00

LE78C:
        .byte   $07                             ; E78C 07
LE78D:
        .byte   $1F                             ; E78D 1F
        .byte   "@A "                           ; E78E 40 41 20
        .byte   $18,$00                         ; E791 18 00

LE793:
        .byte   $08                             ; E793 08
        .byte   " "                             ; E794 20
        .byte   $08,$00                         ; E795 08 00

LE797:
        .byte   "communication coupee dans 30 se"; E797 63 6F 6D 6D 75 6E 69 63
                                                ; E79F 61 74 69 6F 6E 20 63 6F
                                                ; E7A7 75 70 65 65 20 64 61 6E
                                                ; E7AF 73 20 33 30 20 73 65
        .byte   "c"                             ; E7B6 63
        .byte   $00                             ; E7B7 00

LE7B8:
        .byte   "CORRECTION"                    ; E7B8 43 4F 52 52 45 43 54 49
                                                ; E7C0 4F 4E
        .byte   $00                             ; E7C2 00

LE7C3:
        .byte   "ANNULATION"                    ; E7C3 41 4E 4E 55 4C 41 54 49
                                                ; E7CB 4F 4E
        .byte   $00                             ; E7CD 00

LE7CE:
        .byte   "RETOUR"                        ; E7CE 52 45 54 4F 55 52
        .byte   $00                             ; E7D4 00

LE7D5:
        .byte   "pas de SUITE"                  ; E7D5 70 61 73 20 64 65 20 53
                                                ; E7DD 55 49 54 45
        .byte   $00                             ; E7E1 00

LE7E2:
        .byte   "taper quelque chose avant ENVOI"; E7E2 74 61 70 65 72 20 71 75
                                                ; E7EA 65 6C 71 75 65 20 63 68
                                                ; E7F2 6F 73 65 20 61 76 61 6E
                                                ; E7FA 74 20 45 4E 56 4F 49
        .byte   $00                             ; E801 00

LE802:
        .byte   "choix impossible"              ; E802 63 68 6F 69 78 20 69 6D
                                                ; E80A 70 6F 73 73 69 62 6C 65
        .byte   $00                             ; E812 00

LE813:
        .byte   "mot cle impossible"            ; E813 6D 6F 74 20 63 6C 65 20
                                                ; E81B 69 6D 70 6F 73 73 69 62
                                                ; E823 6C 65
        .byte   $00                             ; E825 00

LE826:
        .byte   "erreur systeme,tapez SOMMAIRE" ; E826 65 72 72 65 75 72 20 73
                                                ; E82E 79 73 74 65 6D 65 2C 74
                                                ; E836 61 70 65 7A 20 53 4F 4D
                                                ; E83E 4D 41 49 52 45
        .byte   $00                             ; E843 00

LE844:
        .byte   "pas de GUIDE"                  ; E844 70 61 73 20 64 65 20 47
                                                ; E84C 55 49 44 45
        .byte   $00                             ; E850 00

LE851:
        .byte   "touche "                       ; E851 74 6F 75 63 68 65 20
        .byte   $00                             ; E858 00

LE859:
        .byte   " interdite"                    ; E859 20 69 6E 74 65 72 64 69
                                                ; E861 74 65
        .byte   $00                             ; E863 00
; ----------------------------------------------------------------------------
LE864:
        .byte   $00,$21,$2C,$37,$3E,$4B,$6B,$7C ; E864 00 21 2C 37 3E 4B 6B 7C
        .byte   $8F,$AD                         ; E86C 8F AD
; ----------------------------------------------------------------------------
; Envoie PRO1 (ESC+9) vers le minitel
LE86E:
        jsr     LE874                           ; E86E 20 74 E8

        lda     #$39                            ; E871 A9 39
        ; Masque l'instruction suivante
        .byte   $2C                             ; E873 2C

LE874:
	; Envoie ESC vers le minitel
        lda     #$1B                            ; E874 A9 1B
        ; Masque l'instruction suivante
        .byte   $2C                             ; E876 2C

LE877:
        lda     #$13                            ; E877 A9 13

        _XWR1                                   ; E879 00 11

        rts                                     ; E87B 60

; ----------------------------------------------------------------------------
LE87C:
        tya                                     ; E87C 98
        pha                                     ; E87D 48

        lda     #<LE793                         ; E87E A9 93
        ldy     #>LE793                         ; E880 A0 E7
        _XWSTR0                                 ; E882 00 14

        .byte   $2C                             ; E884 2C
LE885:
        tya                                     ; E885 98
        pha                                     ; E886 48

        lda     #<LE793                         ; E887 A9 93
        ldy     #>LE793                         ; E889 A0 E7
        _XWSTR1                                 ; E88B 00 15

        pla                                     ; E88D 68
        tay                                     ; E88E A8
        rts                                     ; E88F 60

; ----------------------------------------------------------------------------
LE890:
        jsr     LE8AB                           ; E890 20 AB E8
        jsr     LE963                           ; E893 20 63 E9

        lda     $ED                             ; E896 A5 ED
        and     #$C0                            ; E898 29 C0
        cmp     #$C0                            ; E89A C9 C0
        beq     LE8AA                           ; E89C F0 0C

        ; Place le curseur en ligne 0, colonne 1
        ; et efface la ligne
        lda     #<LE78D                         ; E89E A9 8D
        ldy     #>LE78D                         ; E8A0 A0 E7
        _XWSTR1                                 ; E8A2 00 15

        lda     #<(BUFTXT+7)                    ; E8A4 A9 07
        ldy     #>(BUFTXT+7)                    ; E8A6 A0 80
        _XWSTR1                                 ; E8A8 00 15

LE8AA:
        rts                                     ; E8AA 60

; ----------------------------------------------------------------------------
LE8AB:
        stx     RES                             ; E8AB 86 00
        sta     RES+1                           ; E8AD 85 01
        stx     $E8                             ; E8AF 86 E8
        sta     $E9                             ; E8B1 85 E9

        ; RESB := BARBRE
        lda     #<BARBRE                        ; E8B3 A9 00
        ldy     #>BARBRE                        ; E8B5 A0 40
        sta     RESB                            ; E8B7 85 02
        sty     RESB+1                          ; E8B9 84 03
LE8BB:
        txa                                     ; E8BB 8A
        ora     RES+1                           ; E8BC 05 01
        beq     LE8D6                           ; E8BE F0 16

        ldy     #$00                            ; E8C0 A0 00
        lda     (RESB),y                        ; E8C2 B1 02
        clc                                     ; E8C4 18
        adc     RESB                            ; E8C5 65 02
        sta     RESB                            ; E8C7 85 02
        bcc     LE8CD                           ; E8C9 90 02
        inc     RESB+1                          ; E8CB E6 03

LE8CD:
        txa                                     ; E8CD 8A
        bne     LE8D2                           ; E8CE D0 02
        dec     RES+1                           ; E8D0 C6 01

LE8D2:
        dex                                     ; E8D2 CA
        jmp     LE8BB                           ; E8D3 4C BB E8

; ----------------------------------------------------------------------------
LE8D6:
        ldy     #$00                            ; E8D6 A0 00
LE8D8:
        lda     (RESB),y                        ; E8D8 B1 02
        sta     PAGE,y                          ; E8DA 99 C0 9C
        iny                                     ; E8DD C8
        cpy     PAGE                            ; E8DE CC C0 9C
        bne     LE8D8                           ; E8E1 D0 F5

        lda     $9CCC                           ; E8E3 AD CC 9C
        rts                                     ; E8E6 60

; ----------------------------------------------------------------------------
LE8E7:
        ldy     #$80                            ; E8E7 A0 80
        .byte   $2C                             ; E8E9 2C

LE8EA:
        ldy     #$04                            ; E8EA A0 04

        sty     VARAPL                          ; E8EC 84 D0

LE8EE:
        ldx     $9CCA                           ; E8EE AE CA 9C
        txa                                     ; E8F1 8A
        ora     $9CCB                           ; E8F2 0D CB 9C
        beq     LE906                           ; E8F5 F0 0F

        lda     $9CCB                           ; E8F7 AD CB 9C
        jsr     LE8AB                           ; E8FA 20 AB E8
        and     VARAPL                          ; E8FD 25 D0
        beq     LE8EE                           ; E8FF F0 ED

        ldx     $E8                             ; E901 A6 E8
        lda     $E9                             ; E903 A5 E9
        rts                                     ; E905 60

; ----------------------------------------------------------------------------
LE906:
        bit     VARAPL                          ; E906 24 D0
        bmi     LE90F                           ; E908 30 05

        ldx     #$09                            ; E90A A2 09
        jmp     LEBFB                           ; E90C 4C FB EB

; ----------------------------------------------------------------------------
LE90F:
        ldx     $9CC8                           ; E90F AE C8 9C
        lda     $9CC9                           ; E912 AD C9 9C
LE915:
        jsr     LE8AB                           ; E915 20 AB E8
        and     #$C0                            ; E918 29 C0
        bmi     LE922                           ; E91A 30 06
        beq     LE90F                           ; E91C F0 F1

        lda     #$00                            ; E91E A9 00
        tax                                     ; E920 AA
        rts                                     ; E921 60

; ----------------------------------------------------------------------------
; Charge AX avec ($E8)
LE922:
        ldx     $E8                             ; E922 A6 E8
        lda     $E9                             ; E924 A5 E9
        rts                                     ; E926 60

; ----------------------------------------------------------------------------
LE927:
         ; Table des mot-cles
        ; RESB := BARBRE
        lda     #<BARBRE                        ; E927 A9 00
        ldy     #>BARBRE                        ; E929 A0 40
        sta     RESB                            ; E92B 85 02
        sty     RESB+1                          ; E92D 84 03

        ; Indice du mot clé
        ; RES := $0000
        lda     #$00                            ; E92F A9 00
        sta     RES                             ; E931 85 00
        sta     RES+1                           ; E933 85 01

LE935:
        ldx     #$07                            ; E935 A2 07
        ldy     #$01                            ; E937 A0 01

LE939:
        lda     (RESB),y                        ; E939 B1 02
        cmp     BUFEDT-1,y                      ; E93B D9 8F 05
        bne     LE94A                           ; E93E D0 0A

        iny                                     ; E940 C8
        dex                                     ; E941 CA
        bne     LE939                           ; E942 D0 F5

        ; Mot-clé trouvé => C=1 et on retourne son indice
        ldx     RES                             ; E944 A6 00
        lda     RES+1                           ; E946 A5 01
        sec                                     ; E948 38
        rts                                     ; E949 60

; ----------------------------------------------------------------------------
LE94A:
        ; Passe au mot clé suivant
        ldy     #$00                            ; E94A A0 00
        clc                                     ; E94C 18
        lda     (RESB),y                        ; E94D B1 02
        adc     RESB                            ; E94F 65 02
        sta     RESB                            ; E951 85 02
        bcc     LE957                           ; E953 90 02
        inc     RESB+1                          ; E955 E6 03

LE957:
        ; Incrémente l'indice du mot clé
        inc     RES                             ; E957 E6 00
        bne     LE95D                           ; E959 D0 02
        inc     RES+1                           ; E95B E6 01

LE95D:
        ; Dernier mot-clé atteint? Non -> LE935
        lda     (RESB),y                        ; E95D B1 02
        bne     LE935                           ; E95F D0 D4

        ; Fin de la table atteinte => C=0
        clc                                     ; E961 18
        rts                                     ; E962 60

; ----------------------------------------------------------------------------
LE963:
        lda     $ED                             ; E963 A5 ED
        eor     #$C0                            ; E965 49 C0
        bne     LE999                           ; E967 D0 30

        ; Efface l'écran et affiche "Mot cle:"
        ; en ligne 19 colonne 1
        lda     #<LE77F                         ; E969 A9 7F
        ldy     #>LE77F                         ; E96B A0 E7
        _XWSTR1                                 ; E96D 00 15

        ; Affiche 7 caractères
        ldx     #$01                            ; E96F A2 01
LE971:
        lda     PAGE,x                          ; E971 BD C0 9C
        _XWR1                                   ; E974 00 11

        inx                                     ; E976 E8
        cpx     #$08                            ; E977 E0 08
        bne     LE971                           ; E979 D0 F6


        bit     $9CCC                           ; E97B 2C CC 9C
        bpl     LE98B                           ; E97E 10 0B

        lda     #'-'                            ; E980 A9 2D
        _XWR1                                   ; E982 00 11

        lda     $9CCD                           ; E984 AD CD 9C
        ora     #'0'                            ; E987 09 30
        _XWR1                                   ; E989 00 11

LE98B:
        rts                                     ; E98B 60

; ----------------------------------------------------------------------------
LE98C:
        .byte   $00                             ; E98C 00
        .byte   "1234567  VDT"                  ; E98D 31 32 33 34 35 36 37 20
                                                ; E995 20 56 44 54
; ----------------------------------------------------------------------------
        ; Initialise BUFNOM := "1234567  VDT"
LE999:
        ldx     #$0C                            ; E999 A2 0C
LE99B:
        lda     LE98C,x                         ; E99B BD 8C E9
        sta     BUFNOM,x                        ; E99E 9D 17 05
        dex                                     ; E9A1 CA
        bpl     LE99B                           ; E9A2 10 F7

        ; Copie le nom du fichier dans BUFNOM
        ldx     #$07                            ; E9A4 A2 07
LE9A6:
        lda     PAGE,x                          ; E9A6 BD C0 9C
        sta     BUFNOM,x                        ; E9A9 9D 17 05
        dex                                     ; E9AC CA
        bne     LE9A6                           ; E9AD D0 F7

        ; B7-b6: n° de lecteur
        ; Place le n° de lecteur dans DRIVE
        lda     $9CCF                           ; E9AF AD CF 9C
        asl     a                               ; E9B2 0A
        rol     a                               ; E9B3 2A
        rol     a                               ; E9B4 2A
        and     #$03                            ; E9B5 29 03
        sta     DRIVE                           ; E9B7 8D 00 05

        lda     #$C5                            ; E9BA A9 C5
LE9BC:
        ; Exécute une fonction STRATSED si il est présent (n'affiche pas d'erreur si pas de STRATSED)
        jsr     LE5EC                           ; E9BC 20 EC E5

        tax                                     ; E9BF AA
        beq     LE98B                           ; E9C0 F0 C9

        ldx     #$08                            ; E9C2 A2 08
        jmp     LEBFB                           ; E9C4 4C FB EB

; ----------------------------------------------------------------------------
;
; Entrée;
;    X: mode de fonctionnement du serveur
;        0 -> "Lancer le serveur"
;        1 -> "Tester le serveur"
;        2 -> "Borne de communication"
;        3 -> "Tester sans acces disque"
_SERVEUR:
        tay                                     ; E9C7 A8

        ; Place le mode de fonctionnement dans b7-b6
        ; de $ED
        txa                                     ; E9C8 8A
        lsr     a                               ; E9C9 4A
        ror     a                               ; E9CA 6A
        ror     a                               ; E9CB 6A
        sta     $ED                             ; E9CC 85 ED

        lda     L0418                           ; E9CE AD 18 04
        pha                                     ; E9D1 48

        ; Sauvegarde S
        tsx                                     ; E9D2 BA
        stx     $E4                             ; E9D3 86 E4

        ; Mode
        bit     $ED                             ; E9D5 24 ED
        bpl     LE9FC                           ; E9D7 10 23

        ; Mode
        bvs     LE9FC                           ; E9D9 70 21

        tya                                     ; E9DB 98
        pha                                     ; E9DC 48

        lda     #XSCR                           ; E9DD A9 88
        _XCL0                                   ; E9DF 00 04

        lda     #XKBD                           ; E9E1 A9 80
        _XCL0                                   ; E9E3 00 04

        lda     #XMDS                           ; E9E5 A9 8F
        _XOP0                                   ; E9E7 00 00

        lda     #XVDT                           ; E9E9 A9 91
        _XOP1                                   ; E9EB 00 01

        lda     #XKBD                           ; E9ED A9 80
        _XOP1                                   ; E9EF 00 01

        pla                                     ; E9F1 68
        cmp     #$20                            ; E9F2 C9 20
        bne     LE9F9                           ; E9F4 D0 03

        ; Affiche les 3 lignes de statut en bas de l'écran
        jsr     LF56B                           ; E9F6 20 6B F5

LE9F9:
        jmp     LEA8F                           ; E9F9 4C 8F EA

; ----------------------------------------------------------------------------
LE9FC:
        lda     #XMDE                           ; E9FC A9 82
        _XOP1                                   ; E9FE 00 01

        bit     FLGTEL                          ; EA00 2C 0D 02
        bvc     LEA09                           ; EA03 50 04

        lda     #XMDS                           ; EA05 A9 8F
        _XCL0                                   ; EA07 00 04

LEA09:
        lda     #XMDS                           ; EA09 A9 8F
        _XOP1                                   ; EA0B 00 01

LEA0D:
        ldx     $E4                             ; EA0D A6 E4
        txs                                     ; EA0F 9A
        pla                                     ; EA10 68
        pha                                     ; EA11 48
        sta     L0418                           ; EA12 8D 18 04
        bit     $ED                             ; EA15 24 ED
        bmi     LE9F9                           ; EA17 30 E0

        bvs     LE9F9                           ; EA19 70 DE

        ; "Attente de communication"
        lda     #<LE70C                         ; EA1B A9 0C
        ldy     #>LE70C                         ; EA1D A0 E7
        _XWSTR0                                 ; EA1F 00 14

LEA21:
        _XRING                                  ; EA21 00 62
        bcc     LEA7E                           ; EA23 90 59

        _XRD0                                   ; EA25 00 08
        bcs     LEA21                           ; EA27 B0 F8

        cmp     #$03                            ; EA29 C9 03
        beq     LEA38                           ; EA2B F0 0B

        cmp     #$12                            ; EA2D C9 12
        bne     LEA21                           ; EA2F D0 F0

        lda     #XLPR                           ; EA31 A9 8E
        _XOP0                                   ; EA33 00 00

        jmp     LEA21                           ; EA35 4C 21 EA

; ----------------------------------------------------------------------------
LEA38:
        ldx     $E4                             ; EA38 A6 E4
        txs                                     ; EA3A 9A
        pla                                     ; EA3B 68
        sta     L0418                           ; EA3C 8D 18 04

        ldx     #XRSSBU                         ; EA3F A2 18
        _XTSTBU                                 ; EA41 00 56
        bcc     LEA38                           ; EA43 90 F3

LEA45:
        _XRD1                                   ; EA45 00 09
        bcc     LEA45                           ; EA47 90 FC

        lda     #XLPR                           ; EA49 A9 8E
        _XCL0                                   ; EA4B 00 04

        bit     $ED                             ; EA4D 24 ED
        bpl     LEA68                           ; EA4F 10 17
        bvs     LEA68                           ; EA51 70 15

        lda     #XMDS                           ; EA53 A9 8F
        _XCL0                                   ; EA55 00 04

        lda     #XSCR                           ; EA57 A9 88
        _XOP0                                   ; EA59 00 00

        lda     #XKBD                           ; EA5B A9 80
        _XOP0                                   ; EA5D 00 00

        lda     #XVDT                           ; EA5F A9 91
        _XCL1                                   ; EA61 00 05

        lda     #XKBD                           ; EA63 A9 80
        _XCL1                                   ; EA65 00 05
        rts                                     ; EA67 60

; ----------------------------------------------------------------------------
LEA68:
        lda     #XMDE                           ; EA68 A9 82
        _XCL1                                   ; EA6A 00 05

        lda     #XMDS                           ; EA6C A9 8F
        _XCL1                                   ; EA6E 00 05

        ; /?\ $81 := Réservé constructeur...
        lda     #$81                            ; EA70 A9 81
        _XOP0                                   ; EA72 00 00

        bit     FLGTEL                          ; EA74 2C 0D 02
        bvc     LEA7D                           ; EA77 50 04

        lda     #XMDS                           ; EA79 A9 8F
        _XOP0                                   ; EA7B 00 00
LEA7D:
        rts                                     ; EA7D 60

; ----------------------------------------------------------------------------
LEA7E:
        _XLIGNE                                 ; EA7E 00 64

        ; "Attente du correspondant"
        lda     #<LE73C                         ; EA80 A9 3C
        ldy     #>LE73C                         ; EA82 A0 E7
        _XWSTR0                                 ; EA84 00 14

        _XSCXFI                                 ; EA86 00 63
        bcc     LEA8F                           ; EA88 90 05

        _XDECON                                 ; EA8A 00 65
        jmp     LEA0D                           ; EA8C 4C 0D EA

; ----------------------------------------------------------------------------
LEA8F:
        ; "Debut d'emission"
        lda     #<LE728                         ; EA8F A9 28
        ldy     #>LE728                         ; EA91 A0 E7
        _XWSTR0                                 ; EA93 00 14

	; "serveur TELESTRAT (c)  ORIC"
        lda     #<LE6E0                         ; EA95 A9 E0
        ldy     #>LE6E0                         ; EA97 A0 E6
        _XWSTR1                                 ; EA99 00 15

        ; Attente de 30 dixième de secondes
        lda     #$1E                            ; EA9B A9 1E
        sta     TIMEUD                          ; EA9D 85 44
LEA9F:
        lda     TIMEUD                          ; EA9F A5 44
        bne     LEA9F                           ; EAA1 D0 FC

        lda     #$00                            ; EAA3 A9 00
        tax                                     ; EAA5 AA

LEAA6:
        stx     $E6                             ; EAA6 86 E6
        sta     $E7                             ; EAA8 85 E7

        ; "Emission de la page"
        lda     #<LE762                         ; EAAA A9 62
        ldy     #>LE762                         ; EAAC A0 E7
        _XWSTR0                                 ; EAAE 00 14

        ldx     $E6                             ; EAB0 A6 E6
        lda     $E7                             ; EAB2 A5 E7
        jsr     LE890                           ; EAB4 20 90 E8

        ldy     #$F9                            ; EAB7 A0 F9
LEAB9:
        lda     $9BC8,y                         ; EAB9 B9 C8 9B
        _XWR0                                   ; EABC 00 10

        iny                                     ; EABE C8
        bne     LEAB9                           ; EABF D0 F8

        dey                                     ; EAC1 88
        sty     BITMFC                          ; EAC2 8C 44 05

        lda     #$02                            ; EAC5 A9 02
        sta     NBFIC                           ; EAC7 8D 49 05

        lda     #<(BUFTXT+$0840)                ; EACA A9 40
        ldy     #>(BUFTXT+$0840)                ; EACC A0 88
        sta     TAMPFC                          ; EACE 8D 42 05
        sty     TAMPFC+1                        ; EAD1 8C 43 05

        lda     #<LE77A                         ; EAD4 A9 7A
        ldy     #>LE77A                         ; EAD6 A0 E7
        _XWSTR0                                 ; EAD8 00 14

        lda     $9CCC                           ; EADA AD CC 9C
        lsr     a                               ; EADD 4A
        bcc     LEAE8                           ; EADE 90 08

        lda     #$B9                            ; EAE0 A9 B9
        jsr     LE9BC                           ; EAE2 20 BC E9
        jmp     LEB08                           ; EAE5 4C 08 EB

; ----------------------------------------------------------------------------
LEAE8:
        lda     $9CCC                           ; EAE8 AD CC 9C
        and     #$08                            ; EAEB 29 08
        beq     LEB1F                           ; EAED F0 30

        lda     #$00                            ; EAEF A9 00
        sta     $FF                             ; EAF1 85 FF

        lda     VAPLIC                          ; EAF3 AD FD 02
        ldy     VAPLIC+1                        ; EAF6 AC FE 02
        ldx     VAPLIC+2                        ; EAF9 AE FF 02
        sta     BNKCID                          ; EAFC 8D 17 04
        sty     VEXBNK+1                        ; EAFF 8C 15 04
        stx     VEXBNK+2                        ; EB02 8E 16 04
        jsr     EXBNK                           ; EB05 20 0C 04

LEB08:
        ldx     #$00                            ; EB08 A2 00
        ldy     $FF                             ; EB0A A4 FF
        beq     LEB5D                           ; EB0C F0 4F

        cpy     #$A0                            ; EB0E C0 A0
        beq     LEB19                           ; EB10 F0 07

        cpy     #$A9                            ; EB12 C0 A9
        beq     LEB1C                           ; EB14 F0 06

        jmp     LEB63                           ; EB16 4C 63 EB

; ----------------------------------------------------------------------------
LEB19:
        jmp     LEB9A                           ; EB19 4C 9A EB

; ----------------------------------------------------------------------------
LEB1C:
        jmp     LEBB0                           ; EB1C 4C B0 EB

; ----------------------------------------------------------------------------
LEB1F:
        lda     $9CCC                           ; EB1F AD CC 9C
        and     #$10                            ; EB22 29 10
        beq     LEB5D                           ; EB24 F0 37

        ldy     $9CCD                           ; EB26 AC CD 9C
        beq     LEB49                           ; EB29 F0 1E

        sty     TIMEUS                          ; EB2B 84 42

LEB2D:
        bit     KBDCTC                          ; EB2D 2C 7E 02
        bmi     LEB5A                           ; EB30 30 28

        _XRD1                                   ; EB32 00 09
        bcs     LEB45                           ; EB34 B0 0F

        ldy     #$07                            ; EB36 A0 07
        sty     VARAPL                          ; EB38 84 D0
        ldy     #$00                            ; EB3A A0 00
        jsr     LEC8C                           ; EB3C 20 8C EC
        jsr     LECE7                           ; EB3F 20 E7 EC
        jmp     LEB62                           ; EB42 4C 62 EB

; ----------------------------------------------------------------------------
LEB45:
        lda     TIMEUS                          ; EB45 A5 42
        bne     LEB2D                           ; EB47 D0 E4

LEB49:
        bit     $9CCC                           ; EB49 2C CC 9C
        ldx     $9CC8                           ; EB4C AE C8 9C
        lda     $9CC9                           ; EB4F AD C9 9C
        bvc     LEB57                           ; EB52 50 03

        jsr     LE8EA                           ; EB54 20 EA E8
LEB57:
        jmp     LEAA6                           ; EB57 4C A6 EA

; ----------------------------------------------------------------------------
LEB5A:
        jmp     LEA38                           ; EB5A 4C 38 EA

; ----------------------------------------------------------------------------
LEB5D:
        ldx     #$07                            ; EB5D A2 07
        jsr     LECDC                           ; EB5F 20 DC EC
LEB62:
        tay                                     ; EB62 A8
LEB63:
        lda     $9CCC                           ; EB63 AD CC 9C
        cpy     #$A0                            ; EB66 C0 A0
        bne     LEBA2                           ; EB68 D0 38

        txa                                     ; EB6A 8A
        beq     LEB8F                           ; EB6B F0 22

        bit     $9CCC                           ; EB6D 2C CC 9C
        bpl     LEB9A                           ; EB70 10 28

        lda     BUFEDT                          ; EB72 AD 90 05
        cmp     #'1'                            ; EB75 C9 31
        bcc     LEB9A                           ; EB77 90 21

        cmp     #'9'+1                          ; EB79 C9 3A
        bcs     LEB9A                           ; EB7B B0 1D

        sbc     #'0'                            ; EB7D E9 30
        cmp     $9CCD                           ; EB7F CD CD 9C
        bcs     LEB92                           ; EB82 B0 0E

        asl     a                               ; EB84 0A
        tay                                     ; EB85 A8
        ldx     $9CD0,y                         ; EB86 BE D0 9C
        lda     $9CD1,y                         ; EB89 B9 D1 9C
        jmp     LEAA6                           ; EB8C 4C A6 EA

; ----------------------------------------------------------------------------
LEB8F:
        ldx     #$05                            ; EB8F A2 05
        .byte   $2C                             ; EB91 2C

LEB92:
        ldx     #$06                            ; EB92 A2 06
        .byte   $2C                             ; EB94 2C

LEB95:
        ldx     #$07                            ; EB95 A2 07
        jmp     LEBFB                           ; EB97 4C FB EB

; ----------------------------------------------------------------------------
LEB9A:
        jsr     LE927                           ; EB9A 20 27 E9
        bcc     LEB95                           ; EB9D 90 F6

        jmp     LEAA6                           ; EB9F 4C A6 EA

; ----------------------------------------------------------------------------
LEBA2:
        cpy     #$A1                            ; EBA2 C0 A1
        bne     LEBC1                           ; EBA4 D0 1B

        txa                                     ; EBA6 8A
        beq     LEBB6                           ; EBA7 F0 0D

        lda     BUFEDT-1,x                      ; EBA9 BD 8F 05
        cmp     #$2A                            ; EBAC C9 2A
        bne     LEBB6                           ; EBAE D0 06

LEBB0:
        jsr     LE8E7                           ; EBB0 20 E7 E8
        jmp     LEAA6                           ; EBB3 4C A6 EA

; ----------------------------------------------------------------------------
LEBB6:
        lda     $9CCC                           ; EBB6 AD CC 9C
        and     #$20                            ; EBB9 29 20
        bne     LEBF9                           ; EBBB D0 3C

        ldy     #$0A                            ; EBBD A0 0A
        bne     LEBE7                           ; EBBF D0 26

LEBC1:
        cpy     #$A2                            ; EBC1 C0 A2
        bne     LEBCC                           ; EBC3 D0 07

        ldx     $E6                             ; EBC5 A6 E6
        lda     $E7                             ; EBC7 A5 E7
        jmp     LEAA6                           ; EBC9 4C A6 EA

; ----------------------------------------------------------------------------
LEBCC:
        cpy     #$A3                            ; EBCC C0 A3
        beq     LEBF3                           ; EBCE F0 23

        cpy     #$A5                            ; EBD0 C0 A5
        bne     LEBDD                           ; EBD2 D0 09

        lda     #$00                            ; EBD4 A9 00
        tax                                     ; EBD6 AA
        jsr     LE915                           ; EBD7 20 15 E9
        jmp     LEAA6                           ; EBDA 4C A6 EA

; ----------------------------------------------------------------------------
LEBDD:
        cpy     #$A7                            ; EBDD C0 A7
        bne     LEBF0                           ; EBDF D0 0F

        and     #$42                            ; EBE1 29 42
        bne     LEBF6                           ; EBE3 D0 11

        ldy     #$08                            ; EBE5 A0 08
LEBE7:
        ldx     PAGE,y                          ; EBE7 BE C0 9C
        lda     PAGE+1,y                        ; EBEA B9 C1 9C
        jmp     LEAA6                           ; EBED 4C A6 EA

; ----------------------------------------------------------------------------
LEBF0:
        jmp     LEB5D                           ; EBF0 4C 5D EB

; ----------------------------------------------------------------------------
LEBF3:
        ; Offset dans la table LE864 => "pas de GUIDE'
        ldx     #$09                            ; EBF3 A2 09
        .byte   $2C                             ; EBF5 2C

LEBF6:
        ; Offset dans la table LE864 => "pas de SUITE"
        ldx     #$04                            ; EBF6 A2 04
        .byte   $2C                             ; EBF8 2C

LEBF9:
        ; Offset dans la table LE864 => "RETOUR"
        ldx     #$03                            ; EBF9 A2 03

LEBFB:
        stx     TR7                             ; EBFB 86 13
        _XCRLF                                  ; EBFD 00 25

        ; Positionne le curseur en Y=0, X=1
        ; Affiche ' ' et efface le reste de la ligne
        lda     #<LE78C                         ; EBFF A9 8C
        ldy     #>LE78C                         ; EC01 A0 E7
        _XWSTR1                                 ; EC03 00 15

        ; TR7 == 0?
        lda     TR7                             ; EC05 A5 13
        beq     LEC16                           ; EC07 F0 0D

        ; TR7 >= 4?
        cmp     #$04                            ; EC09 C9 04
        bcs     LEC16                           ; EC0B B0 09

        ; Ici, TR7 == 1,2,3
        ;
        ; Affiche le message XY sur le canal 0 et le message AY sur le canal 1
        ; AY := 'touche '
        lda     #<LE851                         ; EC0D A9 51
        ldy     #>LE851                         ; EC0F A0 E8
        jsr     LEC5B                           ; EC11 20 5B EC

        sec                                     ; EC14 38
        ; Masque l'instruction suivante
        .byte   $24                             ; EC15 24

LEC16:
        clc                                     ; EC16 18

        ; Sauvegarde P pour plus tard
        php                                     ; EC17 08

        clc                                     ; EC18 18

        ; AY := 'communication coupee dans 30 sec'
        lda     #<LE797                         ; EC19 A9 97
        ldy     #>LE797                         ; EC1B A0 E7

        ; Calcule l'adresse du message
        ldx     TR7                             ; EC1D A6 13
        adc     LE864,x                         ; EC1F 7D 64 E8
        bcc     LEC25                           ; EC22 90 01
        iny                                     ; EC24 C8

LEC25:
        ; Affiche le message XY sur le canal 0 et le message AY sur le canal 1
        sta     TR5                             ; EC25 85 11
        sty     TR6                             ; EC27 84 12
        jsr     LEC5B                           ; EC29 20 5B EC

        ; Restaure P, C=0?
        plp                                     ; EC2C 28
        bcc     LEC36                           ; EC2D 90 07

        ; Affiche le message XY sur le canal 0 et le message AY sur le canal 1
        ; AY := " interdite"
        lda     #<LE859                         ; EC2F A9 59
        ldy     #>LE859                         ; EC31 A0 E8
        jsr     LEC5B                           ; EC33 20 5B EC

LEC36:
        lda     #$0A                            ; EC36 A9 0A
        _XWR1                                   ; EC38 00 11

        ; Passe à la ligne suivanet et affiche '>'
        lda     #<LE77B                         ; EC3A A9 7B
        ldy     #>LE77B                         ; EC3C A0 E7
        _XWSTR0                                 ; EC3E 00 14

        ; TR7 < 3?
        lda     TR7                             ; EC40 A5 13
        cmp     #$03                            ; EC42 C9 03
        bcc     LEC5A                           ; EC44 90 14

        ; Non
        ldy     $E5                             ; EC46 A4 E5
        beq     LEC50                           ; EC48 F0 06

LEC4A:
        jsr     LE885                           ; EC4A 20 85 E8
        dey                                     ; EC4D 88
        bne     LEC4A                           ; EC4E D0 FA

LEC50:
        ldx     $E8                             ; EC50 A6 E8
        lda     $E9                             ; EC52 A5 E9
        jsr     LE8AB                           ; EC54 20 AB E8

        jmp     LEB5D                           ; EC57 4C 5D EB

; ----------------------------------------------------------------------------
LEC5A:
        rts                                     ; EC5A 60

; ----------------------------------------------------------------------------
; Affiche le message XY sur le canal 0 et le message AY sur le canal 1
;
; Entrée:
;    XY: Adresse première chaine du message
;    AY: Adresse 2nde chaine du message
LEC5B:
        ; Empile A,Y
        tax                                     ; EC5B AA
        pha                                     ; EC5C 48
        tya                                     ; EC5D 98
        pha                                     ; EC5E 48

        ; Affiche le message XY
        txa                                     ; EC5F 8A
        _XWSTR0                                 ; EC60 00 14

        ; Restaure A,Y
        pla                                     ; EC62 68
        tay                                     ; EC63 A8
        pla                                     ; EC64 68

        ; Affiche le message AY
        _XWSTR1                                 ; EC65 00 15

        rts                                     ; EC67 60

; ----------------------------------------------------------------------------
LEC68:
        ; "deconnexion dans 30 sec"
        ldx     #$00                            ; EC68 A2 00
        jsr     LEBFB                           ; EC6A 20 FB EB

        dec     TIMEUS                          ; EC6D C6 42
        jmp     LEC76                           ; EC6F 4C 76 EC

; ----------------------------------------------------------------------------
; Saisir un caractère dans A
_XTGET:
        ; Timeout := 120 secondes
        ldx     #$78                            ; EC72 A2 78
        stx     TIMEUS                          ; EC74 86 42

LEC76:
        _XRD1                                   ; EC76 00 09
        ; Caractère reçu?
        bcc     LEC8C                           ; EC78 90 12

        ; Non, on vérifie le timeout
        lda     TIMEUS                          ; EC7A A5 42
        beq     LEC68                           ; EC7C F0 EA

        bpl     LEC84                           ; EC7E 10 04

        ; Délai supplémentaire de 30 secondes
        ; écoulé? oui -> Déconnexion
        cmp     #$E1                            ; EC80 C9 E1
        bcc     LECBC                           ; EC82 90 38

LEC84:
        ; CTRL+C? non -> boucle
        bit     KBDCTC                          ; EC84 2C 7E 02
        bpl     LEC76                           ; EC87 10 ED

        ; Oui
        jmp     LEA38                           ; EC89 4C 38 EA

; ----------------------------------------------------------------------------
LEC8C:
        bit     $ED                             ; EC8C 24 ED
        bpl     LECA9                           ; EC8E 10 19
        bvs     LECA9                           ; EC90 70 17

        ; Traitement de la touche de commande
        tax                                     ; EC92 AA
        jsr     LF678                           ; EC93 20 78 F6

        ; Commande trouvée?
        bvc     LECA2                           ; EC96 50 0A

        ; Oui

        ; FUNCT+[ ou FUNCT+]?
        bcs     _XTGET                          ; EC98 B0 D8

        ; Oui, A contient SS2 (jeu G2),
        ; Y contient le caractère
        _XWR1                                   ; EC9A 00 11

        tya                                     ; EC9C 98
        _XWR1                                   ; EC9D 00 11

        jmp     _XTGET                          ; EC9F 4C 72 EC

; ----------------------------------------------------------------------------
LECA2:
        txa                                     ; ECA2 8A
        jsr     LED3E                           ; ECA3 20 3E ED
        jmp     LECB7                           ; ECA6 4C B7 EC

; ----------------------------------------------------------------------------
;
; Entreé:
;    A: Touche à traiter
LECA9:
        cmp     #' '                            ; ECA9 C9 20
        bcs     LECBB                           ; ECAB B0 0E

        ; SEP (CTRL+S)?
        cmp     #$13                            ; ECAD C9 13
        bne     LECBB                           ; ECAF D0 0A

        ; Oui, on a reçu une touche de fonction
        ; il faut prendre le caractère suivant
        jsr     _XTGET                          ; ECB1 20 72 EC

        ; Ajoute $5F au code du second caractère
        clc                                     ; ECB4 18
        adc     #$5F                            ; ECB5 69 5F
LECB7:
        cmp     #MNTL_CNXFI                     ; ECB7 C9 A8
        beq     LECBC                           ; ECB9 F0 01

LECBB:
        rts                                     ; ECBB 60

; ----------------------------------------------------------------------------
LECBC:
        jsr     LECC4                           ; ECBC 20 C4 EC

        _XDECON                                 ; ECBF 00 65

        jmp     LEA0D                           ; ECC1 4C 0D EA

; ----------------------------------------------------------------------------
LECC4:
        jsr     LE877                           ; ECC4 20 77 E8

        lda     #$49                            ; ECC7 A9 49
        _XWR1                                   ; ECC9 00 11

        rts                                     ; ECCB 60

; ----------------------------------------------------------------------------
; Instruction Hyperbasic TINPUT
_XTINPUT:
        ; Récupère la longueur de la saisie
        ldx     ACC1E                           ; ECCC A6 60

        jsr     LECDC                           ; ECCE 20 DC EC

        ; Code de la touche de sortie dans $FF
        ; $A0: [ENVOI]
        ; $A1: [RETOUR]
        ; $A2: [REPETITION]
        ; $A3: [GUIDE]
        ; $A5: [SOMMAIRE]
        ; $A7: [SUITE]
        ; $A9: * [RETOUR]
        sta     $FF                             ; ECD1 85 FF

        ldy     #<BUFEDT                        ; ECD3 A0 90
        sty     ACC1M                           ; ECD5 84 61
        ldy     #>BUFEDT                        ; ECD7 A0 05
        sty     ACC1M+1                         ; ECD9 84 62
        rts                                     ; ECDB 60

; ----------------------------------------------------------------------------
; Saisie d'une chaine
;
; Entrée:
;    X: Longueur de la saisie
;
; Sortie:
;    A: Code de la touche de sortie
;    X: Longueur réelle de la chaine (sans la justification à droite)
;    Y: Longueur de la chaine (avec la justification à droite)
; BUFEDT: Chaine justifiée à droite avec des ' ' au besoin
LECDC:
        stx     VARAPL                          ; ECDC 86 D0

LECDE:
        ; Longeur de la chaine reçue
        ldy     #$00                            ; ECDE A0 00

LECE0:
        ; Sauvegarde Y
        sty     $E5                             ; ECE0 84 E5

        ; Attente d'un caractère
        jsr     _XTGET                          ; ECE2 20 72 EC

        ; Restaure Y
        ldy     $E5                             ; ECE5 A4 E5

LECE7:
        cmp     #' '                            ; ECE7 C9 20
        bcc     LED28                           ; ECE9 90 3D

        ; Touche de fonction? oui -> LED01
        cmp     #MNTL_ENVOI                     ; ECEB C9 A0
        bcs     LED01                           ; ECED B0 12

        ; Longueur maximale atteinte?
        ; Oui -> boucle en attente d'une touche de fonction
        cpy     VARAPL                          ; ECEF C4 D0
        bcs     LECE0                           ; ECF1 B0 ED

        ; Ajoute le caractère dans BUFEDT
        sta     BUFEDT,y                        ; ECF3 99 90 05

        ; b6 == 1?
        bit     $ED                             ; ECF6 24 ED
        bvs     LECFC                           ; ECF8 70 02

        ; Non, envoyer aussi le caractère vers le canal 1
        _XWR1                                   ; ECFA 00 11

LECFC:
        _XWR0                                   ; ECFC 00 10
        iny                                     ; ECFE C8
        bne     LECE0                           ; ECFF D0 DF

; [CORRECTION]?
LED01:
        cmp     #MNTL_CORRECTION                ; ED01 C9 A6
        bne     LED19                           ; ED03 D0 14

        ; Chaine vide?
        tya                                     ; ED05 98
        beq     LED11                           ; ED06 F0 09

        ; Non, correction et boucle
        jsr     LE87C                           ; ED08 20 7C E8
        dey                                     ; ED0B 88
        bpl     LECE0                           ; ED0C 10 D2

LED0E:
        ldx     #$02                            ; ED0E A2 02

        ; Masque l'instruction suivante
        .byte   $2C                             ; ED10 2C

LED11:
        ldx     #$01                            ; ED11 A2 01

        jsr     LEBFB                           ; ED13 20 FB EB
        jmp     LECDE                           ; ED16 4C DE EC

; ----------------------------------------------------------------------------
; [ANNULATION]?
LED19:
        cmp     #MNTL_ANNULATION                ; ED19 C9 A4
        bne     LED28                           ; ED1B D0 0B

        tya                                     ; ED1D 98
        beq     LED0E                           ; ED1E F0 EE

LED20:
        jsr     LE87C                           ; ED20 20 7C E8
        dey                                     ; ED23 88
        bne     LED20                           ; ED24 D0 FA
        beq     LECE0                           ; ED26 F0 B8

; ----------------------------------------------------------------------------
LED28:
        ; Sauvegarde la touche de sortie
        pha                                     ; ED28 48

        ; Place la longueur de la chaine reçue dans X
        tya                                     ; ED29 98
        tax                                     ; ED2A AA

        ; Complète la chaine avec des ' '
        lda     #' '                            ; ED2B A9 20
LED2D:
        ; Nombre de caractère saisis >= nombre attendu?
        cpy     VARAPL                          ; ED2D C4 D0
        bcs     LED37                           ; ED2F B0 06
        sta     BUFEDT,y                        ; ED31 99 90 05
        iny                                     ; ED34 C8
        bne     LED2D                           ; ED35 D0 F6

LED37:
        ; Marque la fin du buffer
        lda     #$00                            ; ED37 A9 00
        sta     BUFEDT,y                        ; ED39 99 90 05

        ; Restaure la touche de sortie et fin
        pla                                     ; ED3C 68
        rts                                     ; ED3D 60

; ----------------------------------------------------------------------------
LED3E:
        ldx     #$08                            ; ED3E A2 08
LED40:
        cmp     LED4D,x                         ; ED40 DD 4D ED
        beq     LED49                           ; ED43 F0 04

        dex                                     ; ED45 CA
        bpl     LED40                           ; ED46 10 F8

        rts                                     ; ED48 60

; ----------------------------------------------------------------------------
LED49:
        txa                                     ; ED49 8A
        adc     #$9F                            ; ED4A 69 9F
        rts                                     ; ED4C 60

; ----------------------------------------------------------------------------
LED4D:
        .byte   $0D,$0B,$12,$07,$01,$1B,$7F,$0A ; ED4D 0D 0B 12 07 01 1B 7F 0A
        .byte   $04                             ; ED55 04
; ----------------------------------------------------------------------------
LED56:
        .byte   $0C,$0A                         ; ED56 0C 0A
        .byte   "validation (O/N):"             ; ED58 76 61 6C 69 64 61 74 69
                                                ; ED60 6F 6E 20 28 4F 2F 4E 29
                                                ; ED68 3A
        .byte   $00                             ; ED69 00
LED6A:
        .byte   "  COULEUR  "                   ; ED6A 20 20 43 4F 55 4C 45 55
                                                ; ED72 52 20 20
        .byte   $10,$03                         ; ED75 10 03
        .byte   "         "                     ; ED77 20 20 20 20 20 20 20 20
                                                ; ED7F 20
        .byte   $01                             ; ED80 01
        .byte   "G0     "                       ; ED81 47 30 20 20 20 20 20
        .byte   $06                             ; ED88 06
        .byte   "X:   Y:  "                     ; ED89 58 3A 20 20 20 59 3A 20
                                                ; ED91 20
        .byte   $00,$00                         ; ED92 00 00
        .byte   "lignage"                       ; ED94 6C 69 67 6E 61 67 65
        .byte   $00,$00                         ; ED9B 00 00
        .byte   "clignotement"                  ; ED9D 63 6C 69 67 6E 6F 74 65
                                                ; EDA5 6D 65 6E 74
        .byte   $00,$00                         ; EDA9 00 00
        .byte   "graphique "                    ; EDAB 67 72 61 70 68 69 71 75
                                                ; EDB3 65 20
        .byte   $10                             ; EDB5 10
        .byte   "    "                          ; EDB6 20 20 20 20
LEDBA:
        .byte   $02                             ; EDBA 02
        .byte   "Debut:00,00 Fin:00,00 Curseur:0"; EDBB 44 65 62 75 74 3A 30 30
                                                ; EDC3 2C 30 30 20 46 69 6E 3A
                                                ; EDCB 30 30 2C 30 30 20 43 75
                                                ; EDD3 72 73 65 75 72 3A 30
        .byte   "0,00"                          ; EDDA 30 2C 30 30
        .byte   $07                             ; EDDE 07
        .byte   "C E "                          ; EDDF 43 20 45 20
; ----------------------------------------------------------------------------
LEDE3:
        lda     #<(BUFTXT+7)                    ; EDE3 A9 07
        ldy     #>(BUFTXT+7)                    ; EDE5 A0 80
        _XWSTR1                                 ; EDE7 00 15
        rts                                     ; EDE9 60

; ----------------------------------------------------------------------------
LEDEA:
        lda     #<(BUFTXT+7)                    ; EDEA A9 07
        ldy     #>(BUFTXT+7)                    ; EDEC A0 80
        _XWSTR2                                 ; EDEE 00 16
        rts                                     ; EDF0 60

; ----------------------------------------------------------------------------
LEDF1:
        ldx     #$4F                            ; EDF1 A2 4F
LEDF3:
        lda     LED6A,x                         ; EDF3 BD 6A ED
        sta     SCRL25,x                        ; EDF6 9D 68 BF
        dex                                     ; EDF9 CA
        bpl     LEDF3                           ; EDFA 10 F7

        lda     VDTATR                          ; EDFC A5 34
        and     #$07                            ; EDFE 29 07
        sta     SCRL25+1                        ; EE00 8D 69 BF
        lda     VDTPAR                          ; EE03 A5 32
        lsr     a                               ; EE05 4A
        lsr     a                               ; EE06 4A
        lsr     a                               ; EE07 4A
        lsr     a                               ; EE08 4A
        and     #$07                            ; EE09 29 07
        ora     #$10                            ; EE0B 09 10
        sta     SCRL25                          ; EE0D 8D 68 BF
        bit     VDTATR                          ; EE10 24 34
        bmi     LEE23                           ; EE12 30 0F

        bvc     LEE23                           ; EE14 50 0D

        ldx     #$0A                            ; EE16 A2 0A
LEE18:
        lda     SCRL25,x                        ; EE18 BD 68 BF
        ora     #$80                            ; EE1B 09 80
        sta     SCRL25,x                        ; EE1D 9D 68 BF
        dex                                     ; EE20 CA
        bpl     LEE18                           ; EE21 10 F5

LEE23:
        ldx     #$30                            ; EE23 A2 30
        bit     VDTATR                          ; EE25 24 34
        bpl     LEE2A                           ; EE27 10 01
        inx                                     ; EE29 E8

LEE2A:
        stx     SCRL25+24                       ; EE2A 8E 80 BF
        bit     VDTATR                          ; EE2D 24 34
        bpl     LEE37                           ; EE2F 10 06

        bit     VDTASC                          ; EE31 24 33
        bvs     LEE42                           ; EE33 70 0D
        bvc     LEE3D                           ; EE35 50 06

LEE37:
        lda     VDTPAR                          ; EE37 A5 32
        and     #$04                            ; EE39 29 04
        beq     LEE42                           ; EE3B F0 05

LEE3D:
        lda     #$02                            ; EE3D A9 02
        sta     $BF91                           ; EE3F 8D 91 BF
LEE42:
        lda     VDTATR                          ; EE42 A5 34
        and     #$08                            ; EE44 29 08
        beq     LEE4D                           ; EE46 F0 05

        lda     #$04                            ; EE48 A9 04
        sta     $BF9A                           ; EE4A 8D 9A BF
LEE4D:
        bit     FLGVD1                          ; EE4D 24 3D
        bvc     LEE61                           ; EE4F 50 10

        lda     #$06                            ; EE51 A9 06
        sta     $BFA8                           ; EE53 8D A8 BF
        lda     FLGVD1                          ; EE56 A5 3D
        and     #$02                            ; EE58 29 02
        bne     LEE61                           ; EE5A D0 05

        lda     #$04                            ; EE5C A9 04
        sta     $BFA8                           ; EE5E 8D A8 BF
LEE61:
        ldy     #$89                            ; EE61 A0 89
        lda     VDTX                            ; EE63 A5 38
        jsr     LEEBA                           ; EE65 20 BA EE
        ldy     #$8E                            ; EE68 A0 8E
        lda     VDTY                            ; EE6A A5 39
        jmp     LEEBD                           ; EE6C 4C BD EE

; ----------------------------------------------------------------------------
; Mise à jour de la ligne de statut (ligne 27)
;
; "Debut:00,00 Fin:00,00 Curseur:00,00 C E "
LEE6F:
        ldx     #$27                            ; EE6F A2 27
LEE71:
        lda     LEDBA,x                         ; EE71 BD BA ED
        sta     SCRL27,x                        ; EE74 9D B8 BF
        dex                                     ; EE77 CA
        bpl     LEE71                           ; EE78 10 F7

	; Effacement de la page?
        bit     FLGCOD                          ; EE7A 2C 06 80
        bpl     LEE84                           ; EE7D 10 05

        lda     #'E'+$80                        ; EE7F A9 C5
        sta     SCRL27+39                       ; EE81 8D DF BF

LEE84:
	; Affichage du curseur?
        bvc     LEE8B                           ; EE84 50 05

        lda     #'C'+$80                        ; EE86 A9 C3
        sta     SCRL27+37                       ; EE88 8D DD BF

LEE8B:
        ldy     #<(SCRL27+31)                   ; EE8B A0 D7
        lda     CODCX                           ; EE8D AD 04 80
        jsr     LEEBA                           ; EE90 20 BA EE

        ldy     #<(SCRL27+34)                   ; EE93 A0 DA
        lda     CODCY                           ; EE95 AD 05 80
        jsr     LEEBD                           ; EE98 20 BD EE

        ldy     #<(SCRL27+7)                    ; EE9B A0 BF
        lda     CODDX                           ; EE9D AD 00 80
        jsr     LEEBA                           ; EEA0 20 BA EE

        ldy     #<(SCRL27+10)                   ; EEA3 A0 C2
        lda     CODDY                           ; EEA5 AD 02 80
        jsr     LEEBD                           ; EEA8 20 BD EE

        ldy     #<(SCRL27+17)                   ; EEAB A0 C9
        lda     CODFX                           ; EEAD AD 01 80
        jsr     LEEBA                           ; EEB0 20 BA EE

        ldy     #<(SCRL27+20)                   ; EEB3 A0 CC
        lda     CODFY                           ; EEB5 AD 03 80
        bne     LEEBD                           ; EEB8 D0 03

LEEBA:
        clc                                     ; EEBA 18
        adc     #$01                            ; EEBB 69 01
LEEBD:
        sty     TR5                             ; EEBD 84 11
        ldy     #>SCRL27                        ; EEBF A0 BF
        sty     TR6                             ; EEC1 84 12
        ldy     #'0'                            ; EEC3 A0 30
        sty     DEFAFF                          ; EEC5 84 14
        ldx     #$00                            ; EEC7 A2 00
        ldy     #$00                            ; EEC9 A0 00
        _XBINDX                                 ; EECB 00 28
        rts                                     ; EECD 60

; ----------------------------------------------------------------------------
        cmp     #'a'                            ; EECE C9 61
        bcc     LEED8                           ; EED0 90 06

        cmp     #'z'+1                          ; EED2 C9 7B
        bcs     LEED8                           ; EED4 B0 02

        sbc     #$1F                            ; EED6 E9 1F
LEED8:
        rts                                     ; EED8 60

; ----------------------------------------------------------------------------
; Edition PAGES VIDEOTEX
;
; Entrée:
;    X: N° du choix
;       0 -> Edition
;       1 -> Nouvelle page
LEED9:
        txa                                     ; EED9 8A
        beq     LEF16                           ; EEDA F0 3A

        ; "validation (O/N):"
        lda     #<LED56                         ; EEDC A9 56
        ldy     #>LED56                         ; EEDE A0 ED
        _XWSTR0                                 ; EEE0 00 14

        ; Attend l'appui sur une touche
        _XRDW0                                  ; EEE2 00 0C

        cmp     #'O'                            ; EEE4 C9 4F
        bne     LEF0C                           ; EEE6 D0 24

LEEE8:
        lda     #$00                            ; EEE8 A9 00
        sta     BUFTXT+8                        ; EEEA 8D 08 80
        sta     CODCX                           ; EEED 8D 04 80

        jsr     LF2CF                           ; EEF0 20 CF F2

        lda     #$01                            ; EEF3 A9 01
        sta     CODCY                           ; EEF5 8D 05 80

        ; DESALO := BUFTXT
        lda     #<BUFTXT                        ; EEF8 A9 00
        ldy     #>BUFTXT                        ; EEFA A0 80
        sta     DESALO                          ; EEFC 8D 2D 05
        sty     DESALO+1                        ; EEFF 8C 2E 05

        ; FISALO := BUFTXT+8
        lda     #<(BUFTXT+8)                    ; EF02 A9 08
        ldy     #>(BUFTXT+8)                    ; EF04 A0 80
        sta     FISALO                          ; EF06 8D 2F 05
        sty     FISALO+1                        ; EF09 8C 30 05
LEF0C:
        rts                                     ; EF0C 60

; ----------------------------------------------------------------------------
; Sortie écran Videotex sur le canal 2 et minitel sur le canal 1
LEF0D:
        lda     #XVDT                           ; EF0D A9 91
        _XOP2                                   ; EF0F 00 02

        lda     #XMDS                           ; EF11 A9 8F
        _XOP1                                   ; EF13 00 01
        rts                                     ; EF15 60

; ----------------------------------------------------------------------------
; Edition d'une page
LEF16:
	; Sortie Videotex (canal 2) et Minitel (canal 1)
        jsr     LEF0D                           ; EF16 20 0D EF

        ldx     #$00                            ; EF19 A2 00
        stx     $ED                             ; EF1B 86 ED

        _XCOSCR                                 ; EF1D 00 34
        bit     FLGTEL                          ; EF1F 2C 0D 02
        bvc     LEF28                           ; EF22 50 04

        lda     #XMDS                           ; EF24 A9 8F
        _XOP2                                   ; EF26 00 02

LEF28:
        jsr     LEDEA                           ; EF28 20 EA ED

        lda     #$11                            ; EF2B A9 11
        _XWR2                                   ; EF2D 00 12

        lda     #$80                            ; EF2F A9 80
        sta     FLGVD1                          ; EF31 85 3D
        lsr     FLGVD0                          ; EF33 46 3C
        jsr     LEE6F                           ; EF35 20 6F EE
LEF38:
        jsr     LEDF1                           ; EF38 20 F1 ED
        asl     VDTPAR                          ; EF3B 06 32
        sec                                     ; EF3D 38
        ror     VDTPAR                          ; EF3E 66 32
        bit     FLGVD1                          ; EF40 24 3D
        bvc     LEF51                           ; EF42 50 0D

LEF44:
        _XVDTAF                                 ; EF44 00 31
        _XRD0                                   ; EF46 00 08
        php                                     ; EF48 08
        pha                                     ; EF49 48
        _XVDTAF                                 ; EF4A 00 31
        pla                                     ; EF4C 68
        plp                                     ; EF4D 28
        bcs     LEF44                           ; EF4E B0 F4
        .byte   $2C                             ; EF50 2C

LEF51:
        ; Attend l'appui sur une touche
        _XRDW0                                  ; EF51 00 0C

        ; CTRL+C?
        asl     KBDCTC                          ; EF53 0E 7E 02
        bcc     LEF74                           ; EF56 90 1C

        ; Oui
LEF58:
        jsr     _XVDTEX                         ; EF58 20 EC F2
        asl     FLGKBD                          ; EF5B 0E 75 02
        sec                                     ; EF5E 38
        ror     FLGKBD                          ; EF5F 6E 75 02

        lda     #$03                            ; EF62 A9 03
        sta     JCKTAB+6                        ; EF64 8D A3 02

        lda     #XMDS                           ; EF67 A9 8F
        _XCL2                                   ; EF69 00 06

LEF6B:
        lda     #XVDT                           ; EF6B A9 91
        _XCL2                                   ; EF6D 00 06

        lda     #XMDS                           ; EF6F A9 8F
        _XCL1                                   ; EF71 00 05
        rts                                     ; EF73 60

; ----------------------------------------------------------------------------
LEF74:
        tax                                     ; EF74 AA

	; Coordonnées X,Y mode Videotex
        lda     VDTX                            ; EF75 A5 38
        ldy     VDTY                            ; EF77 A4 39

	; Définition du début de la fenêtre
        cpx     #KEY_FUNCT_D                    ; EF79 E0 84
        beq     LEFA4                           ; EF7B F0 27

	; Définition de la fin de la fenêtre
        cpx     #KEY_FUNCT_F                    ; EF7D E0 86
        beq     LEFAC                           ; EF7F F0 2B

	; Définition de la position du curseur
        cpx     #KEY_FUNCT_O                    ; EF81 E0 8F
        beq     LEF9C                           ; EF83 F0 17

	; Bascule effacement de la page
        lda     #$80                            ; EF85 A9 80
        cpx     #KEY_FUNCT_E                    ; EF87 E0 85
        beq     LEF90                           ; EF89 F0 05

	; Bascule affichage du curseur
        lsr     a                               ; EF8B 4A
        cpx     #KEY_FUNCT_P                    ; EF8C E0 90
        bne     LEFB4                           ; EF8E D0 24

LEF90:
        eor     FLGCOD                          ; EF90 4D 06 80
        sta     FLGCOD                          ; EF93 8D 06 80
LEF96:
        jsr     LEE6F                           ; EF96 20 6F EE
        jmp     LEF38                           ; EF99 4C 38 EF

; ----------------------------------------------------------------------------
LEF9C:
        sta     CODCX                           ; EF9C 8D 04 80
        sty     CODCY                           ; EF9F 8C 05 80
        beq     LEF96                           ; EFA2 F0 F2

LEFA4:
        sta     CODDX                           ; EFA4 8D 00 80
        sty     CODDY                           ; EFA7 8C 02 80
        beq     LEF96                           ; EFAA F0 EA

LEFAC:
        sta     CODFX                           ; EFAC 8D 01 80
        sty     CODFY                           ; EFAF 8C 03 80
        beq     LEF96                           ; EFB2 F0 E2

LEFB4:
        cpx     #KEY_FUNCT_Z                    ; EFB4 E0 9A
        bne     LEFC3                           ; EFB6 D0 0B

        ldx     VDTX                            ; EFB8 A6 38
        stx     VARAPL                          ; EFBA 86 D0
        lda     VDTY                            ; EFBC A5 39
        sta     VARAPL+2                        ; EFBE 85 D2
        jmp     LEF38                           ; EFC0 4C 38 EF

; ----------------------------------------------------------------------------
LEFC3:
        cpx     #KEY_FUNCT_X                    ; EFC3 E0 98
        bne     LEFD2                           ; EFC5 D0 0B

        ldx     VDTX                            ; EFC7 A6 38
        stx     VARAPL+1                        ; EFC9 86 D1
        lda     VDTY                            ; EFCB A5 39
        sta     VARAPL+3                        ; EFCD 85 D3
        jmp     LEF38                           ; EFCF 4C 38 EF

; ----------------------------------------------------------------------------
LEFD2:
        cpx     #KEY_FUNCT_C                    ; EFD2 E0 83
        bne     LF02B                           ; EFD4 D0 55

        ldx     #$06                            ; EFD6 A2 06
LEFD8:
        lda     BUFTXT,x                        ; EFD8 BD 00 80
        pha                                     ; EFDB 48
        lda     VARAPL,x                        ; EFDC B5 D0
        sta     BUFTXT,x                        ; EFDE 9D 00 80
        dex                                     ; EFE1 CA
        bpl     LEFD8                           ; EFE2 10 F4

	; Initialisation de FLGCOD: Affichage du curseur
        lda     #$40                            ; EFE4 A9 40
        sta     FLGCOD                          ; EFE6 8D 06 80

        lda     VDTX                            ; EFE9 A5 38
        ldy     VDTY                            ; EFEB A4 39
        sta     CODCX                           ; EFED 8D 04 80
        sty     CODCY                           ; EFF0 8C 05 80
        jsr     _XVDTEX                         ; EFF3 20 EC F2
        ldy     VARAPL+2                        ; EFF6 A4 D2
LEFF8:
        ldx     VARAPL                          ; EFF8 A6 D0
        inx                                     ; EFFA E8
        jsr     US_XY                           ; EFFB 20 DC F1
        dex                                     ; EFFE CA

        lda     #$00                            ; EFFF A9 00
        sta     VDTASC                          ; F001 85 33

	; Attributs: G1, Texte blanc
        lda     #$87                            ; F003 A9 87
        sta     VDTATR                          ; F005 85 34

LF007:
        lda     #' '                            ; F007 A9 20
        _XWR2                                   ; F009 00 12

        inx                                     ; F00B E8
        cpx     VARAPL+1                        ; F00C E4 D1
        bcc     LF007                           ; F00E 90 F7

        beq     LF007                           ; F010 F0 F5

        iny                                     ; F012 C8
        cpy     VARAPL+3                        ; F013 C4 D3
        beq     LEFF8                           ; F015 F0 E1

        bcc     LEFF8                           ; F017 90 DF

        lda     #$0F                            ; F019 A9 0F
        _XWR2                                   ; F01B 00 12

        ldx     #$00                            ; F01D A2 00
LF01F:
        pla                                     ; F01F 68
        sta     BUFTXT,x                        ; F020 9D 00 80
        inx                                     ; F023 E8
        cpx     #$07                            ; F024 E0 07
        bne     LF01F                           ; F026 D0 F7

        jmp     LEF38                           ; F028 4C 38 EF

; ----------------------------------------------------------------------------
LF02B:
        cpx     #KEY_FUNCT_V                    ; F02B E0 96
        bne     LF035                           ; F02D D0 06

        jsr     LF1EB                           ; F02F 20 EB F1
LF032:
        jmp     LEF38                           ; F032 4C 38 EF

; ----------------------------------------------------------------------------
LF035:
        ; Traitement de la touche de commande (dans X)
        jsr     LF678                           ; F035 20 78 F6

        ; Commande trouvée?
        bvc     LF044                           ; F038 50 0A

        ; Oui

        ; FUNCT+[ ou FUNCT+]?
        bcs     LF032                           ; F03A B0 F6

        ; Oui, A contient SS2 (jeu G2),
        ; Y contient le caractère
        _XWR2                                   ; F03C 00 12

        tya                                     ; F03E 98
        _XWR2                                   ; F03F 00 12

        jmp     LEF38                           ; F041 4C 38 EF

; ----------------------------------------------------------------------------
LF044:
        txa                                     ; F044 8A
        bne     LF052                           ; F045 D0 0B

	; Bascule mode trace / efface
        lda     FLGVD1                          ; F047 A5 3D
        eor     #$02                            ; F049 49 02
        sta     FLGVD1                          ; F04B 85 3D

        jmp     LEF38                           ; F04D 4C 38 EF

; ----------------------------------------------------------------------------
        lda     #$09                            ; F050 A9 09
LF052:
	; Ctrl+G?
        cmp     #$07                            ; F052 C9 07
        bne     LF076                           ; F054 D0 20

	; Bascule mode graphique
        lda     FLGVD1                          ; F056 A5 3D
        eor     #$40                            ; F058 49 40
        sta     FLGVD1                          ; F05A 85 3D

	; Si mode graphique, bouton droit=$03
	; et envoie le code DC1 (cuseur ON) vers Videotex
        ldx     #$03                            ; F05C A2 03
        lda     #$11                            ; F05E A9 11
        bit     FLGVD1                          ; F060 24 3D
        bvc     LF068                           ; F062 50 04

	; Sinon, bouton droit=$00
	; et envoie le code DC4 (curseur OFF) vers Videotex
        lda     #$14                            ; F064 A9 14
        ldx     #$00                            ; F066 A2 00

LF068:
        stx     JCKTAB+6                        ; F068 8E A3 02
        _XWR2                                   ; F06B 00 12

	; Coordonnées graphiques Videotex = 0,0
        lda     #$00                            ; F06D A9 00
        sta     VDTGX                           ; F06F 85 3A
        sta     VDTGY                           ; F071 85 3B
        jmp     LEF38                           ; F073 4C 38 EF

; ----------------------------------------------------------------------------
LF076:
	; < Ctrl+H -> LF0C4
        cmp     #$08                            ; F076 C9 08
        bcc     LF0C4                           ; F078 90 4A

	; >= Ctrl+L?
        cmp     #$0C                            ; F07A C9 0C
        bcs     LF0C4                           ; F07C B0 46

	; Ici touche de déplacement du curseur
	; Mode graphique?, non -> LF0C1
        bit     FLGVD1                          ; F07E 24 3D
        bvc     LF0C1                           ; F080 50 3F

	; [<-]?
        cmp     #$08                            ; F082 C9 08
        bne     LF090                           ; F084 D0 0A

	; Déplacement à gauche
        dec     VDTGX                           ; F086 C6 3A
        bpl     LF0BE                           ; F088 10 34

        ldx     #$01                            ; F08A A2 01
        stx     VDTGX                           ; F08C 86 3A
        bne     LF0C1                           ; F08E D0 31

LF090:
	; [->]?
        cmp     #$09                            ; F090 C9 09
        bne     LF0A2                           ; F092 D0 0E

        ldx     VDTGX                           ; F094 A6 3A
        inc     VDTGX                           ; F096 E6 3A
        cpx     #$01                            ; F098 E0 01
        bne     LF0BE                           ; F09A D0 22

        ldx     #$00                            ; F09C A2 00
        stx     VDTGX                           ; F09E 86 3A
        beq     LF0C1                           ; F0A0 F0 1F

LF0A2:
	; [down]?
        cmp     #$0A                            ; F0A2 C9 0A
        bne     LF0B4                           ; F0A4 D0 0E

        ldx     VDTGY                           ; F0A6 A6 3B
        inc     VDTGY                           ; F0A8 E6 3B
        cpx     #$02                            ; F0AA E0 02
        bne     LF0BE                           ; F0AC D0 10

        ldx     #$00                            ; F0AE A2 00
        stx     VDTGY                           ; F0B0 86 3B
        beq     LF0C1                           ; F0B2 F0 0D

LF0B4:
	; [up]
        dec     VDTGY                           ; F0B4 C6 3B
        bpl     LF0BE                           ; F0B6 10 06

        ldx     #$02                            ; F0B8 A2 02
        stx     VDTGY                           ; F0BA 86 3B
        bne     LF0C1                           ; F0BC D0 03

LF0BE:
        jmp     LEF38                           ; F0BE 4C 38 EF

; ----------------------------------------------------------------------------
LF0C1:
        jmp     LF1AB                           ; F0C1 4C AB F1

; ----------------------------------------------------------------------------
LF0C4:
	; [Return]?
        cmp     #$0D                            ; F0C4 C9 0D
        bne     LF0CE                           ; F0C6 D0 06

        _XWR2                                   ; F0C8 00 12

        lda     #$0A                            ; F0CA A9 0A
        bne     LF0C1                           ; F0CC D0 F3

LF0CE:
	; [Delete]?
        cmp     #$7F                            ; F0CE C9 7F
        bne     LF0EF                           ; F0D0 D0 1D

        jsr     LF0DF                           ; F0D2 20 DF F0

        lda     #' '                            ; F0D5 A9 20
        _XWR2                                   ; F0D7 00 12

        jsr     LF0DF                           ; F0D9 20 DF F0
        jmp     LEF38                           ; F0DC 4C 38 EF

; ----------------------------------------------------------------------------
LF0DF:
        lda     VDTATR                          ; F0DF A5 34
        bmi     LF0EA                           ; F0E1 30 07

        and     #$20                            ; F0E3 29 20
        beq     LF0EA                           ; F0E5 F0 03

        jsr     LF0EA                           ; F0E7 20 EA F0
LF0EA:
        lda     #$08                            ; F0EA A9 08
        _XWR2                                   ; F0EC 00 12

        rts                                     ; F0EE 60

; ----------------------------------------------------------------------------
LF0EF:
	; [space]?
        cmp     #$20                            ; F0EF C9 20
        bne     LF139                           ; F0F1 D0 46

        bit     FLGVD1                          ; F0F3 24 3D
        bvc     LF139                           ; F0F5 50 42

        bit     VDTATR                          ; F0F7 24 34
        bmi     LF0FF                           ; F0F9 30 04

        lda     #$0E                            ; F0FB A9 0E
        _XWR2                                   ; F0FD 00 12
LF0FF:
        lda     VDTGY                           ; F0FF A5 3B
        asl     a                               ; F101 0A
        adc     VDTGX                           ; F102 65 3A
        tax                                     ; F104 AA
        lda     LF133,x                         ; F105 BD 33 F1
        sta     RES                             ; F108 85 00
        eor     #$3F                            ; F10A 49 3F
        sta     RES+1                           ; F10C 85 01
        lda     FLGVD1                          ; F10E A5 3D
        and     #$02                            ; F110 29 02
        beq     LF118                           ; F112 F0 04

        lda     #$00                            ; F114 A9 00
        sta     RES                             ; F116 85 00
LF118:
        ldy     VDTX                            ; F118 A4 38
        lda     ($30),y                         ; F11A B1 30
        bmi     LF121                           ; F11C 30 03

        lda     #$00                            ; F11E A9 00
        .byte   $2C                             ; F120 2C

LF121:
        lda     ($2E),y                         ; F121 B1 2E
        and     RES+1                           ; F123 25 01
        ora     RES                             ; F125 05 00
        clc                                     ; F127 18
        adc     #$20                            ; F128 69 20
        _XWR2                                   ; F12A 00 12

        lda     #$08                            ; F12C A9 08
        _XWR2                                   ; F12E 00 12

        jmp     LEF38                           ; F130 4C 38 EF

; ----------------------------------------------------------------------------
LF133:
        .byte   $01,$02,$04,$08,$10,$20         ; F133 01 02 04 08 10 20
; ----------------------------------------------------------------------------
LF139:
	; Ctrl+A?
        cmp     #$01                            ; F139 C9 01
        bne     LF15E                           ; F13B D0 21

        ldy     VDTX                            ; F13D A4 38
        lda     ($2E),y                         ; F13F B1 2E
        bpl     LF14F                           ; F141 10 0C

        and     #$04                            ; F143 29 04
        sta     RES                             ; F145 85 00
        lda     ($30),y                         ; F147 B1 30
        and     #$70                            ; F149 29 70
        ora     RES                             ; F14B 05 00
        bcs     LF159                           ; F14D B0 0A

LF14F:
        sta     VDTASC                          ; F14F 85 33
        lda     ($30),y                         ; F151 B1 30
        sta     VDTATR                          ; F153 85 34
        bpl     LF15B                           ; F155 10 04

        and     #$70                            ; F157 29 70
LF159:
        sta     VDTPAR                          ; F159 85 32
LF15B:
        jmp     LEF38                           ; F15B 4C 38 EF

; ----------------------------------------------------------------------------
LF15E:
	; Ctrl+B?
        cmp     #$02                            ; F15E C9 02
        bne     LF184                           ; F160 D0 22

        ldy     VDTX                            ; F162 A4 38
        ldx     #$20                            ; F164 A2 20
        lda     ($2E),y                         ; F166 B1 2E
        bmi     LF175                           ; F168 30 0B

        tax                                     ; F16A AA
        lda     ($30),y                         ; F16B B1 30
        bpl     LF17B                           ; F16D 10 0C

        txa                                     ; F16F 8A
        and     #$3F                            ; F170 29 3F
        adc     #$1F                            ; F172 69 1F
        tax                                     ; F174 AA

LF175:
        txa                                     ; F175 8A

LF176:
        _XWR2                                   ; F176 00 12
        jmp     LEF38                           ; F178 4C 38 EF

; ----------------------------------------------------------------------------
LF17B:
        txa                                     ; F17B 8A
        cpx     #$20                            ; F17C E0 20
        bcs     LF176                           ; F17E B0 F6

        ora     #$80                            ; F180 09 80
        bcc     LF176                           ; F182 90 F2

LF184:
	; Ctrl+R?
        cmp     #$12                            ; F184 C9 12
        bne     LF191                           ; F186 D0 09

        jsr     LF1B8                           ; F188 20 B8 F1
        jsr     LEDE3                           ; F18B 20 E3 ED
        jmp     LEF38                           ; F18E 4C 38 EF

; ----------------------------------------------------------------------------
LF191:
	; Ctrl+S?
        cmp     #$13                            ; F191 C9 13
        bne     LF19E                           ; F193 D0 09

        jsr     LF1B8                           ; F195 20 B8 F1
        jsr     LEDEA                           ; F198 20 EA ED
        jmp     LEF38                           ; F19B 4C 38 EF

; ----------------------------------------------------------------------------
LF19E:
	; Ctrl+E?
        cmp     #$05                            ; F19E C9 05
        bne     LF1AB                           ; F1A0 D0 09

        jsr     LEF58                           ; F1A2 20 58 EF
        jsr     LE131                           ; F1A5 20 31 E1
        jmp     LEF16                           ; F1A8 4C 16 EF

; ----------------------------------------------------------------------------
LF1AB:
	; Ctrl+T?
        cmp     #$14                            ; F1AB C9 14
        beq     LF1B5                           ; F1AD F0 06

	; Ctrl+C?
        cmp     #$03                            ; F1AF C9 03
        beq     LF1B5                           ; F1B1 F0 02

	; Aucune touche de contrôle, on affiche
	; le caractère vers Videotex
        _XWR2                                   ; F1B3 00 12

LF1B5:
        jmp     LEF38                           ; F1B5 4C 38 EF

; ----------------------------------------------------------------------------
LF1B8:
        lda     VDTASC                          ; F1B8 A5 33
        pha                                     ; F1BA 48
        lda     VDTATR                          ; F1BB A5 34
        pha                                     ; F1BD 48
        lda     VDTPAR                          ; F1BE A5 32
        pha                                     ; F1C0 48
        lda     VDTX                            ; F1C1 A5 38
        pha                                     ; F1C3 48
        lda     VDTY                            ; F1C4 A5 39
        pha                                     ; F1C6 48
        jsr     _XVDTEX                         ; F1C7 20 EC F2
        pla                                     ; F1CA 68
        tay                                     ; F1CB A8
        pla                                     ; F1CC 68
        tax                                     ; F1CD AA
        inx                                     ; F1CE E8
        jsr     US_XY                           ; F1CF 20 DC F1
        pla                                     ; F1D2 68
        sta     VDTPAR                          ; F1D3 85 32
        pla                                     ; F1D5 68
        sta     VDTATR                          ; F1D6 85 34
        pla                                     ; F1D8 68
        sta     VDTASC                          ; F1D9 85 33
        rts                                     ; F1DB 60

; ----------------------------------------------------------------------------
; Positionne le curseur en X,Y sur Videotex
US_XY:
	; US
        lda     #$1F                            ; F1DC A9 1F
        _XWR2                                   ; F1DE 00 12

	; Y+64
        tya                                     ; F1E0 98
        ora     #$40                            ; F1E1 09 40
        _XWR2                                   ; F1E3 00 12

	; X+64
        txa                                     ; F1E5 8A
        ora     #$40                            ; F1E6 09 40
        _XWR2                                   ; F1E8 00 12

        rts                                     ; F1EA 60

; ----------------------------------------------------------------------------
LF1EB:
        lda     #<(BUFTXT+7)                    ; F1EB A9 07
        ldy     #>(BUFTXT+7)                    ; F1ED A0 80
        sta     RES                             ; F1EF 85 00
        sty     RES+1                           ; F1F1 84 01
        sec                                     ; F1F3 38
        lda     VDTX                            ; F1F4 A5 38
        tax                                     ; F1F6 AA
        sbc     VARAPL                          ; F1F7 E5 D0
        sta     TR0                             ; F1F9 85 0C
        stx     VARAPL                          ; F1FB 86 D0
        sec                                     ; F1FD 38
        lda     VDTY                            ; F1FE A5 39
        tax                                     ; F200 AA
        sbc     VARAPL+2                        ; F201 E5 D2
        sta     TR1                             ; F203 85 0D
        stx     VARAPL+2                        ; F205 86 D2
LF207:
        ldy     #$00                            ; F207 A0 00
        lda     (RES),y                         ; F209 B1 00
        beq     LF242                           ; F20B F0 35

        cmp     #$1F                            ; F20D C9 1F
        bne     LF239                           ; F20F D0 28

        ldy     #$03                            ; F211 A0 03
        lda     (RES),y                         ; F213 B1 00
        beq     LF242                           ; F215 F0 2B

        ldy     #$01                            ; F217 A0 01
        lda     (RES),y                         ; F219 B1 00
        pha                                     ; F21B 48
        iny                                     ; F21C C8
        lda     (RES),y                         ; F21D B1 00
        clc                                     ; F21F 18
        adc     TR0                             ; F220 65 0C
        cmp     #$69                            ; F222 C9 69
        bcc     LF228                           ; F224 90 02
        sbc     #$28                            ; F226 E9 28

LF228:
        tax                                     ; F228 AA
        pla                                     ; F229 68
        adc     TR1                             ; F22A 65 0D
        cmp     #$59                            ; F22C C9 59
        bcc     LF232                           ; F22E 90 02
        sbc     #$18                            ; F230 E9 18

LF232:
        dey                                     ; F232 88
        sta     (RES),y                         ; F233 91 00
        txa                                     ; F235 8A
        iny                                     ; F236 C8
        sta     (RES),y                         ; F237 91 00
LF239:
        iny                                     ; F239 C8
        tya                                     ; F23A 98
        ldy     #$00                            ; F23B A0 00
        _XADRES                                 ; F23D 00 22
        jmp     LF207                           ; F23F 4C 07 F2

; ----------------------------------------------------------------------------
LF242:
        jmp     LEDEA                           ; F242 4C EA ED

; ----------------------------------------------------------------------------
LF245:
	; Ajoute Esc a dans le buffer
        tax                                     ; F245 AA
LF246:
	; Ajoute ESC x dans le buffer
        lda     #$1B                            ; F246 A9 1B
        jsr     LF24F                           ; F248 20 4F F2
LF24B:
        txa                                     ; F24B 8A
        ; Masque l'instruction suivante
        .byte   $2C                             ; F24C 2C

LF24D:
	; Ajoute FF dans le buffer
        lda     #$0C                            ; F24D A9 0C
LF24F:
        sty     RES                             ; F24F 84 00
        ldy     #$00                            ; F251 A0 00
        sta     ($EA),y                         ; F253 91 EA
        inc     $EA                             ; F255 E6 EA
        bne     LF25B                           ; F257 D0 02
        inc     $EB                             ; F259 E6 EB

LF25B:
        ldy     RES                             ; F25B A4 00
        rts                                     ; F25D 60

; ----------------------------------------------------------------------------
; Efface le buffer (le rempli de ' ')
LF25E:
        lda     #<(BUFTXT+7)                    ; F25E A9 07
        ldy     #>(BUFTXT+7)                    ; F260 A0 80
        sta     $EA                             ; F262 85 EA
        sty     $EB                             ; F264 84 EB

	; Effacement de la page?
        bit     FLGCOD                          ; F266 2C 06 80
        bpl     LF2A5                           ; F269 10 3A

	; Oui

        lda     CODDX                           ; F26B AD 00 80
        bne     LF285                           ; F26E D0 15

        lda     CODDY                           ; F270 AD 02 80
        cmp     #$01                            ; F273 C9 01
        bne     LF285                           ; F275 D0 0E

        lda     CODFX                           ; F277 AD 01 80
        cmp     #$27                            ; F27A C9 27
        bne     LF285                           ; F27C D0 07

        lda     CODFY                           ; F27E AD 03 80
        cmp     #$18                            ; F281 C9 18
        beq     LF24D                           ; F283 F0 C8

LF285:
        ldy     CODDY                           ; F285 AC 02 80
LF288:
        jsr     LF2A9                           ; F288 20 A9 F2
        lda     #' '                            ; F28B A9 20
        jsr     LF24F                           ; F28D 20 4F F2
        sec                                     ; F290 38
        lda     CODFX                           ; F291 AD 01 80
        sbc     CODDX                           ; F294 ED 00 80
        tax                                     ; F297 AA
        beq     LF29D                           ; F298 F0 03

        jsr     LF2B9                           ; F29A 20 B9 F2
LF29D:
        iny                                     ; F29D C8
        cpy     CODFY                           ; F29E CC 03 80
        beq     LF288                           ; F2A1 F0 E5

        bcc     LF288                           ; F2A3 90 E3

LF2A5:
        rts                                     ; F2A5 60

; ----------------------------------------------------------------------------
        ldy     CODDY                           ; F2A6 AC 02 80
LF2A9:
        ldx     CODDX                           ; F2A9 AE 00 80
LF2AC:
        inx                                     ; F2AC E8
        jsr     LF2C4                           ; F2AD 20 C4 F2

	; Ajoute US y x dans le buffer
	; (positionnement du curseur)
        lda     #$1F                            ; F2B0 A9 1F
        jsr     LF24F                           ; F2B2 20 4F F2
        tya                                     ; F2B5 98
        ora     #$40                            ; F2B6 09 40
        .byte   $2C                             ; F2B8 2C
LF2B9:
	; Ajoute REP x dans le buffer
	; (effacement de la page)
        lda     #$12                            ; F2B9 A9 12
        jsr     LF24F                           ; F2BB 20 4F F2
        txa                                     ; F2BE 8A
        ora     #$40                            ; F2BF 09 40
        jmp     LF24F                           ; F2C1 4C 4F F2

; ----------------------------------------------------------------------------
LF2C4:
        lda     #$00                            ; F2C4 A9 00
        sta     VDTASC                          ; F2C6 85 33
        sta     VDTPAR                          ; F2C8 85 32
        lda     #$07                            ; F2CA A9 07
        sta     VDTATR                          ; F2CC 85 34
        rts                                     ; F2CE 60

; ----------------------------------------------------------------------------
; Défini la fenêtre: (0,1) - (39,24)
; et flags: Effacement de la page + Affichage du curseur
LF2CF:
        lda     #$00                            ; F2CF A9 00
        ldy     #$01                            ; F2D1 A0 01
        sta     CODDX                           ; F2D3 8D 00 80
        sty     CODDY                           ; F2D6 8C 02 80

        lda     #$27                            ; F2D9 A9 27
        ldy     #$18                            ; F2DB A0 18
        sta     CODFX                           ; F2DD 8D 01 80
        sty     CODFY                           ; F2E0 8C 03 80

	; Effacement de la page + Affichage du curseur
        lda     #$C0                            ; F2E3 A9 C0
        sta     FLGCOD                          ; F2E5 8D 06 80
        rts                                     ; F2E8 60

; ----------------------------------------------------------------------------
LF2E9:
        jsr     LF2CF                           ; F2E9 20 CF F2

; Lancer le codage de la page courante avec les paramètres courants
_XVDTEX:
        ; Sauvegarde FLGVD1
        lda     FLGVD1                          ; F2EC A5 3D
        pha                                     ; F2EE 48

        ; Force b7=0 => curseur éteint
        and     #$7F                            ; F2EF 29 7F
        sta     FLGVD1                          ; F2F1 85 3D

	; Efface le buffer
        jsr     LF25E                           ; F2F3 20 5E F2

	; Met b7 à 1 des 40 octets de la
	; table TABDBH
        ldx     #$27                            ; F2F6 A2 27
LF2F8:
        sec                                     ; F2F8 38
        ror     TABDBH,x                        ; F2F9 7E 80 9C
        dex                                     ; F2FC CA
        bpl     LF2F8                           ; F2FD 10 F9

        lda     CODDY                           ; F2FF AD 02 80
        sta     VDTY                            ; F302 85 39

LF304:
        _XVDTCS                                 ; F304 00 30

        ldy     CODDX                           ; F306 AC 00 80

LF309:
        jsr     LF4C6                           ; F309 20 C6 F4
        bne     LF353                           ; F30C D0 45

LF30E:
        jsr     LF2C4                           ; F30E 20 C4 F2
        jsr     LF4E4                           ; F311 20 E4 F4
        bcc     LF309                           ; F314 90 F3

LF316:
        inc     VDTY                            ; F316 E6 39
        lda     VDTY                            ; F318 A5 39
        cmp     CODFY                           ; F31A CD 03 80
        bcc     LF304                           ; F31D 90 E5

        beq     LF304                           ; F31F F0 E3

	; DC4: curseur off
        lda     #$14                            ; F321 A9 14

	; Affichage du curseur?
        bit     FLGCOD                          ; F323 2C 06 80
        bvc     LF32A                           ; F326 50 02
	; DC1: curseur on
        lda     #$11                            ; F328 A9 11

LF32A:
        jsr     LF24F                           ; F32A 20 4F F2

        ldx     CODCX                           ; F32D AE 04 80
        ldy     CODCY                           ; F330 AC 05 80
        jsr     LF2AC                           ; F333 20 AC F2

	; Ajoute le marqueur de fin dans le buffer
        lda     #$00                            ; F336 A9 00
        jsr     LF24F                           ; F338 20 4F F2

        ; DESALO := BUFTXT
        lda     #<BUFTXT                        ; F33B A9 00
        ldy     #>BUFTXT                        ; F33D A0 80
        sta     DESALO                          ; F33F 8D 2D 05
        sty     DESALO+1                        ; F342 8C 2E 05

        lda     $EA                             ; F345 A5 EA
        ldy     $EB                             ; F347 A4 EB
        sta     FISALO                          ; F349 8D 2F 05
        sty     FISALO+1                        ; F34C 8C 30 05

        ; Restaure FLGVD1
        pla                                     ; F34F 68
        sta     FLGVD1                          ; F350 85 3D

        rts                                     ; F352 60

; ----------------------------------------------------------------------------
LF353:
        tya                                     ; F353 98
        tax                                     ; F354 AA
        ldy     VDTY                            ; F355 A4 39
        jsr     LF2AC                           ; F357 20 AC F2
        dex                                     ; F35A CA
        txa                                     ; F35B 8A
        tay                                     ; F35C A8
LF35D:
        jsr     LF3DE                           ; F35D 20 DE F3
        lda     ($2E),y                         ; F360 B1 2E
        tax                                     ; F362 AA
        lda     ($30),y                         ; F363 B1 30
        bmi     LF382                           ; F365 30 1B

        txa                                     ; F367 8A
        cmp     #$20                            ; F368 C9 20
        bcs     LF38D                           ; F36A B0 21

        ora     #$80                            ; F36C 09 80
        sty     RES+1                           ; F36E 84 01
        _XVDTCV                                 ; F370 00 3B
        pha                                     ; F372 48
        tya                                     ; F373 98
        jsr     LF24F                           ; F374 20 4F F2
        pla                                     ; F377 68
        jsr     LF24F                           ; F378 20 4F F2
        ldy     RES+1                           ; F37B A4 01
        txa                                     ; F37D 8A
        beq     LF390                           ; F37E F0 10

        bne     LF38D                           ; F380 D0 0B

LF382:
        txa                                     ; F382 8A
        bmi     LF38B                           ; F383 30 06
        and     #$3F                            ; F385 29 3F
        clc                                     ; F387 18
        adc     #$20                            ; F388 69 20
        .byte   $2C                             ; F38A 2C
LF38B:
        lda     #$20                            ; F38B A9 20
LF38D:
        jsr     LF24F                           ; F38D 20 4F F2
LF390:
        lda     #$80                            ; F390 A9 80
        sta     TABDBH,y                        ; F392 99 80 9C
        jsr     LF4E4                           ; F395 20 E4 F4
        bcc     LF39D                           ; F398 90 03

        jmp     LF316                           ; F39A 4C 16 F3

; ----------------------------------------------------------------------------
LF39D:
        jsr     LF4C6                           ; F39D 20 C6 F4
        bne     LF3A5                           ; F3A0 D0 03

        jmp     LF30E                           ; F3A2 4C 0E F3

; ----------------------------------------------------------------------------
LF3A5:
        lda     ($2E),y                         ; F3A5 B1 2E
        bmi     LF35D                           ; F3A7 30 B4

        lda     ($30),y                         ; F3A9 B1 30
        and     #$90                            ; F3AB 29 90
        bmi     LF3B1                           ; F3AD 30 02

        bne     LF35D                           ; F3AF D0 AC

LF3B1:
        ldx     #$00                            ; F3B1 A2 00
        sty     $0285                           ; F3B3 8C 85 02
LF3B6:
        dey                                     ; F3B6 88
        lda     ($2E),y                         ; F3B7 B1 2E
        iny                                     ; F3B9 C8
        cmp     ($2E),y                         ; F3BA D1 2E
        bne     LF3C6                           ; F3BC D0 08

        dey                                     ; F3BE 88
        lda     ($30),y                         ; F3BF B1 30
        iny                                     ; F3C1 C8
        cmp     ($30),y                         ; F3C2 D1 30
        beq     LF3D5                           ; F3C4 F0 0F

LF3C6:
        cpx     #$03                            ; F3C6 E0 03
        bcs     LF3CF                           ; F3C8 B0 05

        ldy     $0285                           ; F3CA AC 85 02
        bne     LF35D                           ; F3CD D0 8E

LF3CF:
        jsr     LF2B9                           ; F3CF 20 B9 F2
        jmp     LF309                           ; F3D2 4C 09 F3

; ----------------------------------------------------------------------------
LF3D5:
        jsr     LF4E4                           ; F3D5 20 E4 F4
        inx                                     ; F3D8 E8
        bcc     LF3B6                           ; F3D9 90 DB

        dey                                     ; F3DB 88
        bcs     LF3C6                           ; F3DC B0 E8

LF3DE:
        lda     ($30),y                         ; F3DE B1 30
        tax                                     ; F3E0 AA
        lda     ($2E),y                         ; F3E1 B1 2E
        bpl     LF436                           ; F3E3 10 51

        sta     VDTTR0                          ; F3E5 85 36
        stx     VDTFT                           ; F3E7 86 35
        eor     VDTPAR                          ; F3E9 45 32
        and     #$04                            ; F3EB 29 04
        beq     LF405                           ; F3ED F0 16

        lda     VDTPAR                          ; F3EF A5 32
        and     #$FB                            ; F3F1 29 FB
        sta     VDTPAR                          ; F3F3 85 32
        ldx     #$5A                            ; F3F5 A2 5A
        lda     VDTTR0                          ; F3F7 A5 36
        and     #$04                            ; F3F9 29 04
        bne     LF3FE                           ; F3FB D0 01

        dex                                     ; F3FD CA
LF3FE:
        ora     VDTPAR                          ; F3FE 05 32
        sta     VDTPAR                          ; F400 85 32
        jsr     LF246                           ; F402 20 46 F2
LF405:
        jsr     LF49F                           ; F405 20 9F F4
        lda     VDTATR                          ; F408 A5 34
        and     #$0F                            ; F40A 29 0F
        sta     VDTATR                          ; F40C 85 34
        lda     VDTTR0                          ; F40E A5 36
        and     #$70                            ; F410 29 70
        ora     VDTATR                          ; F412 05 34
        sta     VDTATR                          ; F414 85 34
LF416:
        lda     VDTFT                           ; F416 A5 35
        eor     VDTPAR                          ; F418 45 32
        and     #$70                            ; F41A 29 70
        beq     LF435                           ; F41C F0 17

        lda     VDTPAR                          ; F41E A5 32
        and     #$8F                            ; F420 29 8F
        sta     VDTPAR                          ; F422 85 32
        lda     VDTFT                           ; F424 A5 35
        and     #$70                            ; F426 29 70
        ora     VDTPAR                          ; F428 05 32
        sta     VDTPAR                          ; F42A 85 32
        lsr     a                               ; F42C 4A
        lsr     a                               ; F42D 4A
        lsr     a                               ; F42E 4A
        lsr     a                               ; F42F 4A
        ora     #$50                            ; F430 09 50
        jmp     LF245                           ; F432 4C 45 F2

; ----------------------------------------------------------------------------
LF435:
        rts                                     ; F435 60

; ----------------------------------------------------------------------------
LF436:
        stx     VDTTR0                          ; F436 86 36
        stx     VDTFT                           ; F438 86 35
        lda     VDTTR0                          ; F43A A5 36
        eor     VDTATR                          ; F43C 45 34
        pha                                     ; F43E 48
        bpl     LF457                           ; F43F 10 16

        ldx     #$0F                            ; F441 A2 0F
        lda     ($30),y                         ; F443 B1 30
        bpl     LF44E                           ; F445 10 07

        lda     #$40                            ; F447 A9 40
        sta     VDTASC                          ; F449 85 33
        dex                                     ; F44B CA
        bne     LF454                           ; F44C D0 06

LF44E:
        lda     VDTATR                          ; F44E A5 34
        and     #$0F                            ; F450 29 0F
        sta     VDTATR                          ; F452 85 34
LF454:
        jsr     LF24B                           ; F454 20 4B F2
LF457:
        pla                                     ; F457 68
        pha                                     ; F458 48
        and     #$07                            ; F459 29 07
        beq     LF466                           ; F45B F0 09

        lda     VDTTR0                          ; F45D A5 36
        and     #$07                            ; F45F 29 07
        ora     #$40                            ; F461 09 40
        jsr     LF245                           ; F463 20 45 F2
LF466:
        pla                                     ; F466 68
        and     #$08                            ; F467 29 08
        beq     LF477                           ; F469 F0 0C

        ldx     #$48                            ; F46B A2 48
        lda     VDTTR0                          ; F46D A5 36
        and     #$08                            ; F46F 29 08
        bne     LF474                           ; F471 D0 01

        inx                                     ; F473 E8
LF474:
        jsr     LF246                           ; F474 20 46 F2
LF477:
        lda     ($30),y                         ; F477 B1 30
        bpl     LF499                           ; F479 10 1E

        jsr     LF416                           ; F47B 20 16 F4
        lda     ($2E),y                         ; F47E B1 2E
        eor     VDTASC                          ; F480 45 33
        and     #$40                            ; F482 29 40
        beq     LF494                           ; F484 F0 0E

        ldx     #$5A                            ; F486 A2 5A
        lda     ($2E),y                         ; F488 B1 2E
        sta     VDTASC                          ; F48A 85 33
        and     #$40                            ; F48C 29 40
        beq     LF491                           ; F48E F0 01

        dex                                     ; F490 CA
LF491:
        jsr     LF246                           ; F491 20 46 F2
LF494:
        lda     VDTTR0                          ; F494 A5 36
        sta     VDTATR                          ; F496 85 34
LF498:
        rts                                     ; F498 60

; ----------------------------------------------------------------------------
LF499:
        jsr     LF49F                           ; F499 20 9F F4
        jmp     LF494                           ; F49C 4C 94 F4

; ----------------------------------------------------------------------------
LF49F:
        lda     VDTTR0                          ; F49F A5 36
        eor     VDTATR                          ; F4A1 45 34
        pha                                     ; F4A3 48
        and     #$40                            ; F4A4 29 40
        beq     LF4B4                           ; F4A6 F0 0C

        ldx     #$5D                            ; F4A8 A2 5D
        lda     VDTTR0                          ; F4AA A5 36
        and     #$40                            ; F4AC 29 40
        bne     LF4B1                           ; F4AE D0 01

        dex                                     ; F4B0 CA
LF4B1:
        jsr     LF246                           ; F4B1 20 46 F2
LF4B4:
        pla                                     ; F4B4 68
        and     #$30                            ; F4B5 29 30
        beq     LF498                           ; F4B7 F0 DF

        lda     VDTTR0                          ; F4B9 A5 36
        and     #$30                            ; F4BB 29 30
        lsr     a                               ; F4BD 4A
        lsr     a                               ; F4BE 4A
        lsr     a                               ; F4BF 4A
        lsr     a                               ; F4C0 4A
        ora     #$4C                            ; F4C1 09 4C
        jmp     LF245                           ; F4C3 4C 45 F2

; ----------------------------------------------------------------------------
LF4C6:
        lda     ($2E),y                         ; F4C6 B1 2E
        bmi     LF4CE                           ; F4C8 30 04

        lda     ($30),y                         ; F4CA B1 30
        bmi     LF4D7                           ; F4CC 30 09

LF4CE:
        and     #$10                            ; F4CE 29 10
        beq     LF4D7                           ; F4D0 F0 05

        lda     TABDBH,y                        ; F4D2 B9 80 9C
        bmi     LF4DE                           ; F4D5 30 07

LF4D7:
        cmp     #$87                            ; F4D7 C9 87
        bne     LF4DD                           ; F4D9 D0 02

        lda     ($2E),y                         ; F4DB B1 2E
LF4DD:
        rts                                     ; F4DD 60

; ----------------------------------------------------------------------------
LF4DE:
        lda     #$00                            ; F4DE A9 00
        sta     TABDBH,y                        ; F4E0 99 80 9C
        rts                                     ; F4E3 60

; ----------------------------------------------------------------------------
LF4E4:
        iny                                     ; F4E4 C8
        lda     VDTATR                          ; F4E5 A5 34
        bmi     LF4F4                           ; F4E7 30 0B

        and     #$20                            ; F4E9 29 20
        beq     LF4F4                           ; F4EB F0 07

        lda     VDTDES+127,y                    ; F4ED B9 7F 9C
        sta     TABDBH,y                        ; F4F0 99 80 9C
        iny                                     ; F4F3 C8
LF4F4:
        cpy     CODFX                           ; F4F4 CC 01 80
        beq     LF4FA                           ; F4F7 F0 01

        rts                                     ; F4F9 60

; ----------------------------------------------------------------------------
LF4FA:
        clc                                     ; F4FA 18
        rts                                     ; F4FB 60

; ----------------------------------------------------------------------------
; Lignes de statut (3 dernières lignes de l'écran)
LF4FC:
        .byte   "CX/FIN:"                       ; F4FC 43 58 2F 46 49 4E 3A
        .byte   $06                             ; F503 06
        .byte   "Ctl D"                         ; F504 43 74 6C 20 44
        .byte   $07                             ; F509 07
        .byte   "SOMMAIRE:"                     ; F50A 53 4F 4D 4D 41 49 52 45
                                                ; F512 3A
        .byte   $06                             ; F513 06
        .byte   "ESC"                           ; F514 45 53 43
        .byte   $07                             ; F517 07
        .byte   "GUIDE:"                        ; F518 47 55 49 44 45 3A
        .byte   $06                             ; F51E 06
        .byte   "Ctl GCORREC.:"                 ; F51F 43 74 6C 20 47 43 4F 52
                                                ; F527 52 45 43 2E 3A
        .byte   $06                             ; F52C 06
        .byte   "DEL"                           ; F52D 44 45 4C
        .byte   $07                             ; F530 07
        .byte   "ANNUL.:"                       ; F531 41 4E 4E 55 4C 2E 3A
        .byte   $06                             ; F538 06
        .byte   "Ctl A"                         ; F539 43 74 6C 20 41
        .byte   $07                             ; F53E 07
        .byte   "REPET.:"                       ; F53F 52 45 50 45 54 2E 3A
        .byte   $06                             ; F546 06
        .byte   "Ctl RSUITE:"                   ; F547 43 74 6C 20 52 53 55 49
                                                ; F54F 54 45 3A
        .byte   $06                             ; F552 06
        .byte   "Cur bas"                       ; F553 43 75 72 20 62 61 73
        .byte   $07                             ; F55A 07
        .byte   "RETOUR:"                       ; F55B 52 45 54 4F 55 52 3A
        .byte   $06                             ; F562 06
        .byte   "Cur ht"                        ; F563 43 75 72 20 68 74
        .byte   $07,$14                         ; F569 07 14
; ----------------------------------------------------------------------------
; Affiche les 3 lignes de statut en bas de l'écran
LF56B:
        ldx     #$6E                            ; F56B A2 6E
LF56D:
        lda     LF4FC,x                         ; F56D BD FC F4
        sta     SCRL25,x                        ; F570 9D 68 BF
        dex                                     ; F573 CA
        bpl     LF56D                           ; F574 10 F7

        rts                                     ; F576 60

; ----------------------------------------------------------------------------
LF577:
        lda     VDTX                            ; F577 A5 38
        ldy     VDTY                            ; F579 A4 39
        sta     CODCX                           ; F57B 8D 04 80
        sty     CODCY                           ; F57E 8C 05 80

        lda     #$00                            ; F581 A9 00

        ; Curseur allumé?
        bit     FLGVD1                          ; F583 24 3D
        bpl     LF589                           ; F585 10 02

        ; Oui
        lda     #$40                            ; F587 A9 40

LF589:
        sta     FLGCOD                          ; F589 8D 06 80
        jsr     LF2E9                           ; F58C 20 E9 F2

        lda     #XMDE                           ; F58F A9 82
        _XCL1                                   ; F591 00 05

        ; Stoppe l'affichage de l'horloge
        _XCLCL                                  ; F593 00 3D

        jmp     LEF6B                           ; F595 4C 6B EF

; ----------------------------------------------------------------------------
LF598:
        jsr     LEF0D                           ; F598 20 0D EF
        ldx     #$00                            ; F59B A2 00
        _XCOSCR                                 ; F59D 00 34

        lda     #XMDE                           ; F59F A9 82
        _XOP1                                   ; F5A1 00 01

        ; Affiche l'horloge en ligne 27, colonne 31
        lda     #<(SCREEN+27*40+31)             ; F5A3 A9 D7
        ldy     #>(SCREEN+27*40+31)             ; F5A5 A0 BF
        _XWRCLK                                 ; F5A7 00 3E

        ; Affiche les 3 lignes de statut en bas de l'écran
        jsr     LF56B                           ; F5A9 20 6B F5

        jsr     LEDEA                           ; F5AC 20 EA ED
        lsr     $EC                             ; F5AF 46 EC
LF5B1:
        _XRD0                                   ; F5B1 00 08
        bcc     LF5BB                           ; F5B3 90 06

        jsr     LF671                           ; F5B5 20 71 F6
        jmp     LF5B1                           ; F5B8 4C B1 F5

; ----------------------------------------------------------------------------
LF5BB:
        asl     KBDCTC                          ; F5BB 0E 7E 02
        bcs     LF577                           ; F5BE B0 B7

	; Funct+D?
        cmp     #$84                            ; F5C0 C9 84
        bne     LF5C9                           ; F5C2 D0 05

        _XLIGNE                                 ; F5C4 00 64
        jmp     LF5B1                           ; F5C6 4C B1 F5

; ----------------------------------------------------------------------------
LF5C9:
	; Funct+F?
        cmp     #$86                            ; F5C9 C9 86
        bne     LF5D2                           ; F5CB D0 05

        _XDECON                                 ; F5CD 00 65
        jmp     LF5B1                           ; F5CF 4C B1 F5

; ----------------------------------------------------------------------------
LF5D2:
        ; Traitement de la touche de commande (dans X)
        tax                                     ; F5D2 AA
        jsr     LF678                           ; F5D3 20 78 F6

        ; Commande trouvée?
        bvc     LF5E4                           ; F5D6 50 0C

        ; Oui

        ; FUNCT+[ ou FUNCT+]?
        bcs     LF5B1                           ; F5D8 B0 D7

        ; Oui, A contient SS2 (jeu G2),
        ; Y contient le caractère
        jsr     LF66B                           ; F5DA 20 6B F6
        tya                                     ; F5DD 98
        jsr     LF66B                           ; F5DE 20 6B F6

        jmp     LF5B1                           ; F5E1 4C B1 F5

; ----------------------------------------------------------------------------
LF5E4:
        txa                                     ; F5E4 8A
	; Ctrl+O?
        cmp     #$0F                            ; F5E5 C9 0F
        bne     LF5F1                           ; F5E7 D0 08

        ; Inverse b7 de $EC
        lda     $EC                             ; F5E9 A5 EC
        eor     #$80                            ; F5EB 49 80
        sta     $EC                             ; F5ED 85 EC

        bcs     LF5B1                           ; F5EF B0 C0

LF5F1:
        bit     $EC                             ; F5F1 24 EC
        bmi     LF5FF                           ; F5F3 30 0A

        ldx     #$47                            ; F5F5 A2 47
        cmp     #$7F                            ; F5F7 C9 7F
        beq     LF636                           ; F5F9 F0 3B

        cmp     #' '                            ; F5FB C9 20
        bcc     LF605                           ; F5FD 90 06

LF5FF:
        jsr     LF66B                           ; F5FF 20 6B F6
        jmp     LF5B1                           ; F602 4C B1 F5

; ----------------------------------------------------------------------------
LF605:
	; [Return]?
        ldx     #$41                            ; F605 A2 41
        cmp     #$0D                            ; F607 C9 0D
        beq     LF636                           ; F609 F0 2B

	; [up]?
        inx                                     ; F60B E8
        cmp     #$0B                            ; F60C C9 0B
        beq     LF636                           ; F60E F0 26

	; Ctrl+R?
        inx                                     ; F610 E8
        cmp     #$12                            ; F611 C9 12
        beq     LF636                           ; F613 F0 21

	; Ctrl+G?
        inx                                     ; F615 E8
        cmp     #$07                            ; F616 C9 07
        beq     LF636                           ; F618 F0 1C

	; Ctrl+A?
        inx                                     ; F61A E8
        cmp     #$01                            ; F61B C9 01
        beq     LF636                           ; F61D F0 17

	; [Esc]?
        inx                                     ; F61F E8
        cmp     #$1B                            ; F620 C9 1B
        beq     LF636                           ; F622 F0 12

	; [down]?
        ldx     #$48                            ; F624 A2 48
        cmp     #$0A                            ; F626 C9 0A
        beq     LF636                           ; F628 F0 0C

	; Ctrl+D?
        inx                                     ; F62A E8
        cmp     #$04                            ; F62B C9 04
        bne     LF640                           ; F62D D0 11

	; Envoie PRO1...
        jsr     LE86E                           ; F62F 20 6E E8
	; ...Connexion au minital
        lda     #$68                            ; F632 A9 68
        _XWR1                                   ; F634 00 11

LF636:
        lda     #$13                            ; F636 A9 13
        _XWR1                                   ; F638 00 11

        txa                                     ; F63A 8A
        _XWR1                                   ; F63B 00 11

LF63D:
        jmp     LF5B1                           ; F63D 4C B1 F5

; ----------------------------------------------------------------------------
LF640:
	; Ctrl+E?
        cmp     #$05                            ; F640 C9 05
        bne     LF64D                           ; F642 D0 09

        jsr     LF577                           ; F644 20 77 F5
        jsr     LE131                           ; F647 20 31 E1
        jmp     LF598                           ; F64A 4C 98 F5

; ----------------------------------------------------------------------------
LF64D:
	; Ctrl+X?
        cmp     #$18                            ; F64D C9 18
        bne     LF65E                           ; F64F D0 0D

	; Réinitialise l'horloge
        lda     #$00                            ; F651 A9 00
        sta     TIMEH                           ; F653 8D 13 02
        sta     TIMEM                           ; F656 8D 12 02
        sta     TIMES                           ; F659 8D 11 02
        bcs     LF63D                           ; F65C B0 DF

LF65E:
	; Ctrl+Z?
        nop                                     ; F65E EA
        cmp     #$1A                            ; F65F C9 1A
        bne     LF665                           ; F661 D0 02

        lda     #$1B                            ; F663 A9 1B
LF665:
        jsr     LF66B                           ; F665 20 6B F6
        jmp     LF5B1                           ; F668 4C B1 F5

; ----------------------------------------------------------------------------
LF66B:
        _XWR1                                   ; F66B 00 11
        bit     $EC                             ; F66D 24 EC
        bmi     LF675                           ; F66F 30 04

LF671:
        _XRD1                                   ; F671 00 09
        bcs     LF677                           ; F673 B0 02

LF675:
        _XWR2                                   ; F675 00 12

LF677:
        rts                                     ; F677 60

; ----------------------------------------------------------------------------
; Bascule NB/couleur sur le moniteur?
LF678:
        cpx     #KEY_CTRL_L                     ; F678 E0 0C
        bne     LF687                           ; F67A D0 0B

        lda     FLGVD1                          ; F67C A5 3D
        eor     #$01                            ; F67E 49 01
        sta     FLGVD1                          ; F680 85 3D
LF682:
        sec                                     ; F682 38

        ; Force V=1
        bit     LF686                           ; F683 2C 86 F6

LF686:
        rts                                     ; F686 60

; ----------------------------------------------------------------------------
; Impression ASCII de la page? (caractère alpha-numériques)
LF687:
        cpx     #KEY_FUNCT_A                     ; F687 E0 81
        bne     LF690                           ; F689 D0 05

        _XHCVDT                                 ; F68B 00 4B
        jmp     LF682                           ; F68D 4C 82 F6

; ----------------------------------------------------------------------------
; Impression VIDEOTEX de la page? (hard copy)
LF690:
        cpx     #KEY_FUNCT_I                    ; F690 E0 89
        bne     LF699                           ; F692 D0 05

        _XHCHRS                                 ; F694 00 4C
        jmp     LF682                           ; F696 4C 82 F6

; ----------------------------------------------------------------------------
; Accent aigü?
LF699:
        lda     KBDSHT                          ; F699 AD 78 02
        cpx     #KEY_FUNCT_LBRACKET             ; F69C E0 9B
        bne     LF6A9                           ; F69E D0 09

        ldy     #'B'                            ; F6A0 A0 42

        ; KEY_SHIFT?
        lsr     a                               ; F6A2 4A
        bcc     LF6B4                           ; F6A3 90 0F

        ; KEY_FUNCT_LCURLY -> circonflexe
        ldy     #'C'                            ; F6A5 A0 43
        bcs     LF6B4                           ; F6A7 B0 0B

; ----------------------------------------------------------------------------
; Accent grave?
LF6A9:
        ldy     #'A'                            ; F6A9 A0 41
        cpx     #KEY_FUNCT_RBRACKET             ; F6AB E0 9D
        bne     LF6BB                           ; F6AD D0 0C

        ; KEY_SHIFT?
        lsr     a                               ; F6AF 4A
        bcc     LF6B4                           ; F6B0 90 02

        ; KEY_FUNCT_RCURLY -> Tréma
        ldy     #'H'                            ; F6B2 A0 48

LF6B4:
        ; Indique qu'on a une combinaison avec un accent
        clc                                     ; F6B4 18

        ; SS2 (Jeu G2)
        lda     #$19                            ; F6B5 A9 19

        ; Force V=1
        bit     LF6BA                           ; F6B7 2C BA F6
LF6BA:
        rts                                     ; F6BA 60

; ----------------------------------------------------------------------------
LF6BB:
        clv                                     ; F6BB B8
        rts                                     ; F6BC 60

; ----------------------------------------------------------------------------
LF6BD:
        .byte   "    sec"                       ; F6BD 20 20 20 20 73 65 63
LF6C4:
        .byte   $10                             ; F6C4 10
        .byte   "PAGE000"                       ; F6C5 50 41 47 45 30 30 30
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; F6CC 00 00 00 00 00 00 00 00
        .byte   $00                             ; F6D4 00
; ----------------------------------------------------------------------------
LF6D5:
        stx     VARAPL+2                        ; F6D5 86 D2
        sta     VARAPL+3                        ; F6D7 85 D3
        jsr     LE8AB                           ; F6D9 20 AB E8
        lda     RESB                            ; F6DC A5 02
        ldy     RESB+1                          ; F6DE A4 03
        sta     VARAPL                          ; F6E0 85 D0
        sty     VARAPL+1                        ; F6E2 84 D1
        lda     $9CCC                           ; F6E4 AD CC 9C
        and     #$20                            ; F6E7 29 20
        bne     LF712                           ; F6E9 D0 27

        bit     $9CCC                           ; F6EB 2C CC 9C
        bpl     LF713                           ; F6EE 10 23
        ldy     #$0D                            ; F6F0 A0 0D
        lda     (RESB),y                        ; F6F2 B1 02
        beq     LF713                           ; F6F4 F0 1D

        cmp     #$01                            ; F6F6 C9 01
        bne     LF712                           ; F6F8 D0 18

        ldy     #$10                            ; F6FA A0 10
        lda     (RESB),y                        ; F6FC B1 02
        ldy     #$08                            ; F6FE A0 08
        sta     (RESB),y                        ; F700 91 02
        ldy     #$11                            ; F702 A0 11
        lda     (RESB),y                        ; F704 B1 02
        ldy     #$09                            ; F706 A0 09
        sta     (RESB),y                        ; F708 91 02
        ldy     #$0C                            ; F70A A0 0C
        lda     (RESB),y                        ; F70C B1 02
        and     #$3F                            ; F70E 29 3F
        sta     (RESB),y                        ; F710 91 02
LF712:
        rts                                     ; F712 60

; ----------------------------------------------------------------------------
LF713:
        ldx     $9CCA                           ; F713 AE CA 9C
        lda     $9CCB                           ; F716 AD CB 9C
        jsr     LE8AB                           ; F719 20 AB E8
        bpl     LF79D                           ; F71C 10 7F
        ldy     #$10                            ; F71E A0 10

LF720:
        lda     (RESB),y                        ; F720 B1 02
        iny                                     ; F722 C8
        cmp     VARAPL+2                        ; F723 C5 D2
        bne     LF730                           ; F725 D0 09

        lda     (RESB),y                        ; F727 B1 02
        iny                                     ; F729 C8
        cmp     VARAPL+3                        ; F72A C5 D3
        beq     LF733                           ; F72C F0 05

        bne     LF720                           ; F72E D0 F0

LF730:
        iny                                     ; F730 C8
        bne     LF720                           ; F731 D0 ED

LF733:
        dey                                     ; F733 88
        dey                                     ; F734 88
        sty     VARAPL+4                        ; F735 84 D4
        ldy     #$0C                            ; F737 A0 0C
        lda     (VARAPL),y                      ; F739 B1 D0
        asl     a                               ; F73B 0A
        bmi     LF756                           ; F73C 30 18

        ldy     #$08                            ; F73E A0 08
        lda     (VARAPL),y                      ; F740 B1 D0
        ldy     VARAPL+4                        ; F742 A4 D4
        sta     (RESB),y                        ; F744 91 02
        tax                                     ; F746 AA
        ldy     #$09                            ; F747 A0 09
        lda     (VARAPL),y                      ; F749 B1 D0
        ldy     VARAPL+4                        ; F74B A4 D4
        iny                                     ; F74D C8
        sta     (RESB),y                        ; F74E 91 02
        jsr     LE8AB                           ; F750 20 AB E8
        jmp     LF818                           ; F753 4C 18 F8

; ----------------------------------------------------------------------------
LF756:
        ldy     #$0D                            ; F756 A0 0D
        lda     (RESB),y                        ; F758 B1 02
        sec                                     ; F75A 38
        sbc     #$01                            ; F75B E9 01
        sta     (RESB),y                        ; F75D 91 02
        ldy     #$00                            ; F75F A0 00
        lda     (RESB),y                        ; F761 B1 02
        sbc     #$02                            ; F763 E9 02
        sta     (RESB),y                        ; F765 91 02
        clc                                     ; F767 18
        lda     VARAPL+4                        ; F768 A5 D4
        adc     RESB                            ; F76A 65 02
        sta     DECCIB                          ; F76C 85 08
        tay                                     ; F76E A8
        lda     RESB+1                          ; F76F A5 03
        adc     #$00                            ; F771 69 00
        sta     DECCIB+1                        ; F773 85 09
        tax                                     ; F775 AA
        tya                                     ; F776 98
        clc                                     ; F777 18
        adc     #$02                            ; F778 69 02
        bcc     LF77D                           ; F77A 90 01

        inx                                     ; F77C E8
LF77D:
        sta     DECDEB                          ; F77D 85 04
        stx     DECDEB+1                        ; F77F 86 05
        lda     #$00                            ; F781 A9 00
        ldy     #$80                            ; F783 A0 80
        sta     DECFIN                          ; F785 85 06
        sty     DECFIN+1                        ; F787 84 07
        _XDECAL                                 ; F789 00 18
        ldx     VARAPL+2                        ; F78B A6 D2
        lda     VARAPL+3                        ; F78D A5 D3
        jsr     LE8AB                           ; F78F 20 AB E8
        lda     RESB                            ; F792 A5 02
        ldy     RESB+1                          ; F794 A4 03
        sta     VARAPL                          ; F796 85 D0
        sty     VARAPL+1                        ; F798 84 D1
        jmp     LF7C1                           ; F79A 4C C1 F7

; ----------------------------------------------------------------------------
LF79D:
        ldx     VARAPL+2                        ; F79D A6 D2
        lda     VARAPL+3                        ; F79F A5 D3
        jsr     LE8AB                           ; F7A1 20 AB E8
        bit     PAGE+12                         ; F7A4 2C CC 9C
        bvc     LF7ED                           ; F7A7 50 44

        lda     PAGE+12                         ; F7A9 AD CC 9C
        and     #$20                            ; F7AC 29 20
        bne     LF7EC                           ; F7AE D0 3C

        ldx     PAGE+10                         ; F7B0 AE CA 9C
        lda     PAGE+11                         ; F7B3 AD CB 9C
        jsr     LE8AB                           ; F7B6 20 AB E8

        ldy     #$0C                            ; F7B9 A0 0C
        lda     (RESB),y                        ; F7BB B1 02
        ora     #$40                            ; F7BD 09 40
        sta     (RESB),y                        ; F7BF 91 02
LF7C1:
        ldy     #$00                            ; F7C1 A0 00
        lda     (VARAPL),y                      ; F7C3 B1 D0
        clc                                     ; F7C5 18
        adc     VARAPL                          ; F7C6 65 D0
        sta     DECDEB                          ; F7C8 85 04
        lda     VARAPL+1                        ; F7CA A5 D1
        adc     #$00                            ; F7CC 69 00
        sta     DECDEB+1                        ; F7CE 85 05
        lda     #<BUFTXT                        ; F7D0 A9 00
        ldy     #>BUFTXT                        ; F7D2 A0 80
        sta     DECFIN                          ; F7D4 85 06
        sty     DECFIN+1                        ; F7D6 84 07
        ldx     VARAPL                          ; F7D8 A6 D0
        ldy     VARAPL+1                        ; F7DA A4 D1
        inx                                     ; F7DC E8
        bne     LF7E0                           ; F7DD D0 01

        iny                                     ; F7DF C8
LF7E0:
        stx     DECCIB                          ; F7E0 86 08
        sty     DECCIB+1                        ; F7E2 84 09
        _XDECAL                                 ; F7E4 00 18
        ldy     #$00                            ; F7E6 A0 00
        lda     #$01                            ; F7E8 A9 01
        sta     (VARAPL),y                      ; F7EA 91 D0
LF7EC:
        rts                                     ; F7EC 60

; ----------------------------------------------------------------------------
LF7ED:
        ldx     PAGE+10                         ; F7ED AE CA 9C
        lda     PAGE+11                         ; F7F0 AD CB 9C
        stx     VARAPL+4                        ; F7F3 86 D4
        sta     VARAPL+5                        ; F7F5 85 D5
        jsr     LE8AB                           ; F7F7 20 AB E8
        lda     RESB                            ; F7FA A5 02
        ldy     RESB+1                          ; F7FC A4 03
        sta     VARAPL+2                        ; F7FE 85 D2
        sty     VARAPL+3                        ; F800 84 D3
        ldy     #$08                            ; F802 A0 08
        lda     (VARAPL),y                      ; F804 B1 D0
        tax                                     ; F806 AA
        iny                                     ; F807 C8
        lda     (VARAPL),y                      ; F808 B1 D0
        jsr     LE8AB                           ; F80A 20 AB E8
        ldy     #$08                            ; F80D A0 08
        lda     (VARAPL),y                      ; F80F B1 D0
        sta     (VARAPL+2),y                    ; F811 91 D2
        iny                                     ; F813 C8
        lda     (VARAPL),y                      ; F814 B1 D0
        sta     (VARAPL+2),y                    ; F816 91 D2
LF818:
        ldy     #$0A                            ; F818 A0 0A
        lda     (VARAPL),y                      ; F81A B1 D0
        sta     (RESB),y                        ; F81C 91 02
        iny                                     ; F81E C8
        lda     (VARAPL),y                      ; F81F B1 D0
        sta     (RESB),y                        ; F821 91 02
        jmp     LF7C1                           ; F823 4C C1 F7

; ----------------------------------------------------------------------------
LF826:
        pla                                     ; F826 68
        rts                                     ; F827 60

; ----------------------------------------------------------------------------
LF828:
        pha                                     ; F828 48
        tya                                     ; F829 98
        jsr     LE8AB                           ; F82A 20 AB E8
        bmi     LF8A1                           ; F82D 30 72

        pla                                     ; F82F 68
        pha                                     ; F830 48
        lsr     a                               ; F831 4A
        bcc     LF83F                           ; F832 90 0B

        bit     PAGE+12                         ; F834 2C CC 9C
        bvc     LF826                           ; F837 50 ED

        lda     PAGE+12                         ; F839 AD CC 9C
        lsr     a                               ; F83C 4A
        bcs     LF826                           ; F83D B0 E7

LF83F:
        pla                                     ; F83F 68
        jsr     LF920                           ; F840 20 20 F9
        ldy     #$0C                            ; F843 A0 0C
        lda     (RESB),y                        ; F845 B1 02
        asl     a                               ; F847 0A
        bmi     LF88D                           ; F848 30 43

        ldy     #$08                            ; F84A A0 08
        lda     (RESB),y                        ; F84C B1 02
        sta     VARAPL+4                        ; F84E 85 D4
        sta     (VARAPL),y                      ; F850 91 D0
        iny                                     ; F852 C8
        lda     (RESB),y                        ; F853 B1 02
        sta     VARAPL+5                        ; F855 85 D5
        sta     (VARAPL),y                      ; F857 91 D0
        jsr     LF876                           ; F859 20 76 F8
        ldx     VARAPL+4                        ; F85C A6 D4
        lda     VARAPL+5                        ; F85E A5 D5
        jsr     LE8AB                           ; F860 20 AB E8
        ldy     #$0A                            ; F863 A0 0A
        lda     VARAPL+2                        ; F865 A5 D2
        sta     (RESB),y                        ; F867 91 02
        iny                                     ; F869 C8
        lda     VARAPL+3                        ; F86A A5 D3
        sta     (RESB),y                        ; F86C 91 02
        ldy     #$0C                            ; F86E A0 0C
        lda     (VARAPL),y                      ; F870 B1 D0
        bpl     LF88C                           ; F872 10 18

        bmi     LF8AA                           ; F874 30 34

LF876:
        ldy     #$08                            ; F876 A0 08
        lda     VARAPL+2                        ; F878 A5 D2
        sta     (RESB),y                        ; F87A 91 02
        iny                                     ; F87C C8
        lda     VARAPL+3                        ; F87D A5 D3
        sta     (RESB),y                        ; F87F 91 02
LF881:
        ldy     #$0A                            ; F881 A0 0A
        lda     $E8                             ; F883 A5 E8
        sta     (VARAPL),y                      ; F885 91 D0
        lda     $E9                             ; F887 A5 E9
        iny                                     ; F889 C8
        sta     (VARAPL),y                      ; F88A 91 D0
LF88C:
        rts                                     ; F88C 60

; ----------------------------------------------------------------------------
LF88D:
        jsr     LF876                           ; F88D 20 76 F8
        ldy     #$0C                            ; F890 A0 0C
        lda     (RESB),y                        ; F892 B1 02
        and     #$BF                            ; F894 29 BF
        sta     (RESB),y                        ; F896 91 02
        lda     (VARAPL),y                      ; F898 B1 D0
        ora     #$40                            ; F89A 09 40
        sta     (VARAPL),y                      ; F89C 91 D0
        .byte   $24                             ; F89E 24
LF89F:
        pla                                     ; F89F 68
        rts                                     ; F8A0 60

; ----------------------------------------------------------------------------
LF8A1:
        lda     #$04                            ; F8A1 A9 04
        cmp     PAGE+13                         ; F8A3 CD CD 9C
        bcs     LF8B3                           ; F8A6 B0 0B

        bcc     LF89F                           ; F8A8 90 F5

LF8AA:
        clc                                     ; F8AA 18
        lda     VARAPL                          ; F8AB A5 D0
        ldy     VARAPL+1                        ; F8AD A4 D1
        sta     RESB                            ; F8AF 85 02
        sty     RESB+1                          ; F8B1 84 03
LF8B3:
        php                                     ; F8B3 08
        ldy     #$00                            ; F8B4 A0 00
        clc                                     ; F8B6 18
        lda     RESB                            ; F8B7 A5 02
        ldx     RESB+1                          ; F8B9 A6 03
        adc     (RESB),y                        ; F8BB 71 02
        bcc     LF8C0                           ; F8BD 90 01

        inx                                     ; F8BF E8
LF8C0:
        sta     DECDEB                          ; F8C0 85 04
        stx     DECDEB+1                        ; F8C2 86 05
        clc                                     ; F8C4 18
        adc     #$02                            ; F8C5 69 02
        bcc     LF8CA                           ; F8C7 90 01

        inx                                     ; F8C9 E8
LF8CA:
        sta     DECCIB                          ; F8CA 85 08
        stx     DECCIB+1                        ; F8CC 86 09
        lda     #$FE                            ; F8CE A9 FE
        ldy     #$7F                            ; F8D0 A0 7F
        sta     DECFIN                          ; F8D2 85 06
        sty     DECFIN+1                        ; F8D4 84 07
        _XDECAL                                 ; F8D6 00 18
        ldy     #$00                            ; F8D8 A0 00
        lda     (RESB),y                        ; F8DA B1 02
        clc                                     ; F8DC 18
        adc     #$02                            ; F8DD 69 02
        sta     (RESB),y                        ; F8DF 91 02
        plp                                     ; F8E1 28
        php                                     ; F8E2 08
        bcc     LF8E8                           ; F8E3 90 03

        jsr     LF920                           ; F8E5 20 20 F9
LF8E8:
        ldy     #$0D                            ; F8E8 A0 0D
        lda     (RESB),y                        ; F8EA B1 02
        clc                                     ; F8EC 18
        adc     #$01                            ; F8ED 69 01
        sta     (RESB),y                        ; F8EF 91 02
        ldy     #$00                            ; F8F1 A0 00
        lda     (RESB),y                        ; F8F3 B1 02
        tay                                     ; F8F5 A8
        plp                                     ; F8F6 28
        bcs     LF90A                           ; F8F7 B0 11

        ldy     #$08                            ; F8F9 A0 08
        lda     (RESB),y                        ; F8FB B1 02
        ldy     #$10                            ; F8FD A0 10
        sta     (RESB),y                        ; F8FF 91 02
        ldy     #$09                            ; F901 A0 09
        lda     (RESB),y                        ; F903 B1 02
        ldy     #$11                            ; F905 A0 11
        sta     (RESB),y                        ; F907 91 02
        rts                                     ; F909 60

; ----------------------------------------------------------------------------
LF90A:
        dey                                     ; F90A 88
        lda     VARAPL+3                        ; F90B A5 D3
        sta     (RESB),y                        ; F90D 91 02
        dey                                     ; F90F 88
        lda     VARAPL+2                        ; F910 A5 D2
        sta     (RESB),y                        ; F912 91 02
        lda     #$80                            ; F914 A9 80
        pla                                     ; F916 68
        ora     #$40                            ; F917 09 40
        ldy     #$0C                            ; F919 A0 0C
        sta     (VARAPL),y                      ; F91B 91 D0
        jmp     LF881                           ; F91D 4C 81 F8

; ----------------------------------------------------------------------------
; Calcule l'adresse de fin de l'arborescence et le nombre de pages
; et créé une nouvelle page vide
;
; Entrée:
;    A: caractère à placer après le n° de la page
;
; Sortie:
;    VARAPL: Adresse de début de la nouvelle page (2 octets)
;    VARAPL+2: nombre de pages (2 octets)
LF920:
        clc                                     ; F920 18
        ; Masque l'instruction suivante
        .byte   $24                             ; F921 24

; Calcule l'adresse de fin de l'arborescence et le nombre de pages
;
; Entrée:
;    A: conservé
;
; Sortie:
;    XY: Adresse de fin de l'arborescence+1
;    VARAPL: Adresse de fin de l'arborescence
;    VARAPL+2: nombre de pages (2 octets)
LF922:
        sec                                     ; F922 38

        ; Sauvegarde A et P
        pha                                     ; F923 48
        php                                     ; F924 08

        lda     #<BARBRE                        ; F925 A9 00
        ldy     #>BARBRE                        ; F927 A0 40
        sta     VARAPL                          ; F929 85 D0
        sty     VARAPL+1                        ; F92B 84 D1

        ldy     #$00                            ; F92D A0 00
        sty     VARAPL+2                        ; F92F 84 D2
        sty     VARAPL+3                        ; F931 84 D3

LF933:
        ; Fin de l'arborescence atteinte?
        lda     (VARAPL),y                      ; F933 B1 D0
        bne     LF96C                           ; F935 D0 35

        ; Restaure P
        plp                                     ; F937 28

        ; Si C=0, on veut ajouter une nouvelle page vide
        bcc     LF944                           ; F938 90 0A

        ; Restaure A
        pla                                     ; F93A 68

        ; XY := (VARAPL)+1
        ldx     VARAPL                          ; F93B A6 D0
        ldy     VARAPL+1                        ; F93D A4 D1
        inx                                     ; F93F E8
        bne     LF943                           ; F940 D0 01
        iny                                     ; F942 C8

LF943:
        rts                                     ; F943 60

; ----------------------------------------------------------------------------
; Place l'entête de la page
LF944:
        ; Copie "PAGE000" suivi de 10 octets nul
        lda     LF6C4,y                         ; F944 B9 C4 F6
        sta     (VARAPL),y                      ; F947 91 D0
        iny                                     ; F949 C8
        cpy     #$11                            ; F94A C0 11
        bne     LF944                           ; F94C D0 F6

        ; Restaure A (sauvegardé en LF938)
        pla                                     ; F94E 68

        ; Ajoute A après "PAGExxx"
        ldy     #$0C                            ; F94F A0 0C
        sta     (VARAPL),y                      ; F951 91 D0

        lda     #'0'                            ; F953 A9 30
        sta     DEFAFF                          ; F955 85 14

        ; Calcule VARAPL+4, résultat dans TR5+TR6
        ; soit juste après "PAGE"
        ; (pour XBINDX)
        lda     VARAPL                          ; F957 A5 D0
        adc     #$04                            ; F959 69 04
        sta     TR5                             ; F95B 85 11
        lda     VARAPL+1                        ; F95D A5 D1
        adc     #$00                            ; F95F 69 00
        sta     TR6                             ; F961 85 12

        ; Conversion du nombre de pages en chaine
        ; résultat en (TR5)
        lda     VARAPL+2                        ; F963 A5 D2
        ldy     VARAPL+3                        ; F965 A4 D3
        ldx     #$01                            ; F967 A2 01
        _XBINDX                                 ; F969 00 28

        rts                                     ; F96B 60

; ----------------------------------------------------------------------------
LF96C:
        ; Incrémente le nombre de pages
        inc     VARAPL+2                        ; F96C E6 D2
        bne     LF972                           ; F96E D0 02
        inc     VARAPL+3                        ; F970 E6 D3

LF972:
        ; Passe à la page suivante dans l'arborescence
        clc                                     ; F972 18
        adc     VARAPL                          ; F973 65 D0
        sta     VARAPL                          ; F975 85 D0
        bcc     LF933                           ; F977 90 BA
        inc     VARAPL+1                        ; F979 E6 D1
        bcs     LF933                           ; F97B B0 B6

; ----------------------------------------------------------------------------
; Prend un caractère à l'écran (C=1 si caractère alpha)
;
; Entrée:
;    Y: Offset sur la ligne
;
; Sortie:
;    A: Caractère lu (& $7F)
;    Y: inchangé
;    C:0 si >'Z' ou < 'A'
;    C:1 si >= 'A'
LF97D:
        ; Prend un caractère sur l'écran
        lda     (ADSCR),y                       ; F97D B1 26
        and     #$7F                            ; F97F 29 7F

        ; > 'Z'? -> Fin C=0
        cmp     #'Z'+1                          ; F981 C9 5B
        bcs     LF988                           ; F983 B0 03

        ; Fin (C=1 si >= 'A')
        cmp     #'A'                            ; F985 C9 41
        rts                                     ; F987 60

; ----------------------------------------------------------------------------
LF988:
        clc                                     ; F988 18
        rts                                     ; F989 60

; ----------------------------------------------------------------------------
; Edtion ou nouveau serveur
;
; Entrée:
;    X:  0 -> 'edition'
;        1 -> "nouveau serveur"
LF98A:
        txa                                     ; F98A 8A
        beq     LF9BC                           ; F98B F0 2F

        bne     LF9A3                           ; F98D D0 14

; ----------------------------------------------------------------------------
; Calcule l'adresse de fin de l'arborescence ainsi que le nombre de pages
; et met à jour DESALO et FISALO
LF98F:
        ; DESALO := BARBRE
        lda     #<BARBRE                        ; F98F A9 00
        ldy     #>BARBRE                        ; F991 A0 40
        sta     DESALO                          ; F993 8D 2D 05
        sty     DESALO+1                        ; F996 8C 2E 05

        ; Calcule l'adresse de fin de l'arborescence et le nombre de pages
        jsr     LF922                           ; F999 20 22 F9
        stx     FISALO                          ; F99C 8E 2F 05
        sty     FISALO+1                        ; F99F 8C 30 05
LF9A2:
        rts                                     ; F9A2 60

; ----------------------------------------------------------------------------
; Nouveau serveur
LF9A3:
        ; "validation (O/N):"
        lda     #<LED56                         ; F9A3 A9 56
        ldy     #>LED56                         ; F9A5 A0 ED
        _XWSTR0                                 ; F9A7 00 14

        ; Attend une touche
        _XRDW0                                  ; F9A9 00 0C

        cmp     #'O'                            ; F9AB C9 4F
        bne     LF9A2                           ; F9AD D0 F3

        ; Indique que l'arborescence est vide
        lda     #$00                            ; F9AF A9 00
        sta     BARBRE                          ; F9B1 8D 00 40

        ; Calcule l'adresse de fin de l'arborescence et le nombre de pages
        ; et créé une nouvelle page vide
        lda     #$60                            ; F9B4 A9 60
        jsr     LF920                           ; F9B6 20 20 F9

        ; Calcule l'adresse de fin de l'arborescence ainsi que le nombre de pages
        ; et met à jour DESALO et FISALO
        jmp     LF98F                           ; F9B9 4C 8F F9

; ----------------------------------------------------------------------------
; Edition du serveur
LF9BC:
        ; Arborescence vide? -> Fin
        lda     BARBRE                          ; F9BC AD 00 40
        beq     LF9F8                           ; F9BF F0 37

       ; Affiche le curseur dans la fenêtre 0
        _XCOSCR                                 ; F9C1 00 34

        ; AX := 0
        lda     #$00                            ; F9C3 A9 00
        tax                                     ; F9C5 AA
LF9C6:
        ; Force b7=0
        lsr     VARAPL+14                       ; F9C6 46 DE

        ; Sauvegarde A
        pha                                     ; F9C8 48

        ; Calcule la longueur de la fenêtre
        ; Résultat dans VARAPL+9
        sec                                     ; F9C9 38
        lda     SCRFX                           ; F9CA AD 2C 02
        sbc     SCRDX                           ; F9CD ED 28 02
        adc     #$00                            ; F9D0 69 00
        sta     VARAPL+9                        ; F9D2 85 D9

        ; Calcule la hauteur de la fenêtre /2
        ; Résultat dans VARAPL+11
        lda     SCRFY                           ; F9D4 AD 34 02
        sbc     SCRDY                           ; F9D7 ED 30 02
        lsr     a                               ; F9DA 4A
        sta     VARAPL+11                       ; F9DB 85 DB

        ; Restaure A
        pla                                     ; F9DD 68
        jsr     LFDB7                           ; F9DE 20 B7 FD

        ; Curseur HOME
        lda     #$1E                            ; F9E1 A9 1E
        _XWR0                                   ; F9E3 00 10

        lda     #KEY_RIGHT                      ; F9E5 A9 09
        _XWR0                                   ; F9E7 00 10

        lda     #KEY_RIGHT                      ; F9E9 A9 09
        bne     LFA14                           ; F9EB D0 27

; ----------------------------------------------------------------------------
LF9ED:
        ; Attend une touche
        _XRDW0                                  ; F9ED 00 0C

        ; CTRL+C?
        asl     KBDCTC                          ; F9EF 0E 7E 02
        bcs     LF9F8                           ; F9F2 B0 04


        cmp     #KEY_ESC                        ; F9F4 C9 1B
        bne     LF9FB                           ; F9F6 D0 03

LF9F8:
        ; Calcule l'adresse de fin de l'arborescence ainsi que le nombre de pages
        ; et met à jour DESALO et FISALO
        ; Retour au menu SERVEUR
        jmp     LF98F                           ; F9F8 4C 8F F9

; ----------------------------------------------------------------------------
LF9FB:
        ; Sauvegarde A
        pha                                     ; F9FB 48

        ldy     SCRX                            ; F9FC AC 20 02
        lda     (ADSCR),y                       ; F9FF B1 26
        and     #$7F                            ; FA01 29 7F
        sta     CURSCR                          ; FA03 8D 4C 02

        ; Inverse les 8 caractères suivants à l'écran
        ldx     #$08                            ; FA06 A2 08
        dey                                     ; FA08 88
LFA09:
        lda     (ADSCR),y                       ; FA09 B1 26
        eor     #$80                            ; FA0B 49 80
        sta     (ADSCR),y                       ; FA0D 91 26
        iny                                     ; FA0F C8
        dex                                     ; FA10 CA
        bne     LFA09                           ; FA11 D0 F6

        ; Restaure A
        pla                                     ; FA13 68

LFA14:
        ; FUNCT+I?
        cmp     #KEY_FUNCT_I                    ; FA14 C9 89
        bne     LFA32                           ; FA16 D0 1A

        ; Impression de l'arborescence
        sec                                     ; FA18 38
        ror     VARAPL+14                       ; FA19 66 DE
        lda     LPRFX                           ; FA1B AD 88 02
        sta     VARAPL+9                        ; FA1E 85 D9
        lda     #$FF                            ; FA20 A9 FF
        sta     VARAPL+11                       ; FA22 85 DB
        ldx     $E6                             ; FA24 A6 E6
        lda     $E7                             ; FA26 A5 E7
        jsr     LFDB7                           ; FA28 20 B7 FD
        ldx     $E6                             ; FA2B A6 E6
        lda     $E7                             ; FA2D A5 E7
        jmp     LF9C6                           ; FA2F 4C C6 F9

; ----------------------------------------------------------------------------
; Déplacement vers la gauche dans la partie de l'arbre affichée?
LFA32:
        cmp     #KEY_LEFT                       ; FA32 C9 08
        bne     LFA61                           ; FA34 D0 2B

        lda     SCRX                            ; FA36 AD 20 02
LFA39:
        cmp     #$01                            ; FA39 C9 01
        bne     LFA56                           ; FA3B D0 19

        lda     #$29                            ; FA3D A9 29
        bne     LFA56                           ; FA3F D0 15

; ----------------------------------------------------------------------------
LFA41:
        sty     SCRX                            ; FA41 8C 20 02

LFA44:
        ; Boucle pour inverser les 8 caractères suivants à l'écran
        ldx     #$08                            ; FA44 A2 08
        ldy     SCRX                            ; FA46 AC 20 02
        dey                                     ; FA49 88
LFA4A:
        lda     (ADSCR),y                       ; FA4A B1 26
        eor     #$80                            ; FA4C 49 80
        sta     (ADSCR),y                       ; FA4E 91 26
        iny                                     ; FA50 C8
        dex                                     ; FA51 CA
        bne     LFA4A                           ; FA52 D0 F6

        beq     LF9ED                           ; FA54 F0 97

; ----------------------------------------------------------------------------
LFA56:
        sbc     #$08                            ; FA56 E9 08
        tay                                     ; FA58 A8

        ; Prend un caractère à l'écran (C=1 si caractère alpha)
        jsr     LF97D                           ; FA59 20 7D F9
        bcs     LFA41                           ; FA5C B0 E3

        tya                                     ; FA5E 98
        bcc     LFA39                           ; FA5F 90 D8

; ----------------------------------------------------------------------------
; Déplacement vers la droite dans la partie de l'arbre affichée?
LFA61:
        cmp     #KEY_RIGHT                      ; FA61 C9 09
        bne     LFA7A                           ; FA63 D0 15

        lda     SCRX                            ; FA65 AD 20 02
LFA68:
        cmp     #$21                            ; FA68 C9 21
        bne     LFA6E                           ; FA6A D0 02

        lda     #$F9                            ; FA6C A9 F9
LFA6E:
        clc                                     ; FA6E 18
        adc     #$08                            ; FA6F 69 08
        tay                                     ; FA71 A8

        ; Prend un caractère à l'écran (C=1 si caractère alpha)
        jsr     LF97D                           ; FA72 20 7D F9
        bcs     LFA41                           ; FA75 B0 CA

        tya                                     ; FA77 98
        bcc     LFA68                           ; FA78 90 EE

; ----------------------------------------------------------------------------
; Déplacement vers le bas dans la partie de l'arbre affichée?
LFA7A:
        cmp     #KEY_DOWN                       ; FA7A C9 0A
        bne     LFAAE                           ; FA7C D0 30

        ; Ligne 25?
        lda     SCRY                            ; FA7E AD 24 02
        cmp     #$19                            ; FA81 C9 19
        beq     LFA44                           ; FA83 F0 BF

        ; Non

        ldy     #$50                            ; FA85 A0 50
        ldx     #$28                            ; FA87 A2 28
LFA89:
        lda     (ADSCR),y                       ; FA89 B1 26
        cmp     #' '                            ; FA8B C9 20
        beq     LFA93                           ; FA8D F0 04

        cmp     #$10                            ; FA8F C9 10
        bne     LFA9A                           ; FA91 D0 07

LFA93:
        iny                                     ; FA93 C8
        dex                                     ; FA94 CA
        bne     LFA89                           ; FA95 D0 F2

        jmp     LFA44                           ; FA97 4C 44 FA

; ----------------------------------------------------------------------------
LFA9A:
        lda     #$0A                            ; FA9A A9 0A
        _XWR0                                   ; FA9C 00 10

        lda     #$0A                            ; FA9E A9 0A
        _XWR0                                   ; FAA0 00 10

LFAA2:
        ldy     SCRX                            ; FAA2 AC 20 02

        ; Prend un caractère à l'écran (C=1 si caractère alpha)
        jsr     LF97D                           ; FAA5 20 7D F9
        bcs     LFA44                           ; FAA8 B0 9A

        lda     #$09                            ; FAAA A9 09
        bne     LFA61                           ; FAAC D0 B3

; ----------------------------------------------------------------------------
; Déplacement vers le haut dans la partie de l'arbre affichée?
LFAAE:
        cmp     #KEY_UP                         ; FAAE C9 0B
        bne     LFADC                           ; FAB0 D0 2A

        lda     SCRY                            ; FAB2 AD 24 02
        cmp     #$01                            ; FAB5 C9 01
        bne     LFAD1                           ; FAB7 D0 18

        jsr     LFCD3                           ; FAB9 20 D3 FC
        jsr     LE8AB                           ; FABC 20 AB E8
        and     #$20                            ; FABF 29 20
        beq     LFAC6                           ; FAC1 F0 03

        jmp     LFA44                           ; FAC3 4C 44 FA

; ----------------------------------------------------------------------------
LFAC6:
        ldy     #$0A                            ; FAC6 A0 0A
        lda     (RESB),y                        ; FAC8 B1 02
        tax                                     ; FACA AA
        iny                                     ; FACB C8
        lda     (RESB),y                        ; FACC B1 02
        jmp     LF9C6                           ; FACE 4C C6 F9

; ----------------------------------------------------------------------------
LFAD1:
        lda     #$0B                            ; FAD1 A9 0B
        _XWR0                                   ; FAD3 00 10

        lda     #$0B                            ; FAD5 A9 0B
        _XWR0                                   ; FAD7 00 10

        jmp     LFAA2                           ; FAD9 4C A2 FA

; ----------------------------------------------------------------------------
; Déplacement de l'arbre?
;
; la page sous le curseur se place en haut de l'écran
LFADC:
        cmp     #' '                            ; FADC C9 20
        bne     LFAE9                           ; FADE D0 09

        jsr     LFCD3                           ; FAE0 20 D3 FC
        jmp     LF9C6                           ; FAE3 4C C6 F9

; ----------------------------------------------------------------------------
LFAE6:
        jmp     LFB77                           ; FAE6 4C 77 FB

; ----------------------------------------------------------------------------
; Nommer une page?
LFAE9:
        cmp     #'N'                            ; FAE9 C9 4E
        bne     LFAE6                           ; FAEB D0 F9

        jsr     LFCD3                           ; FAED 20 D3 FC
        jsr     LE8AB                           ; FAF0 20 AB E8

        lda     #$11                            ; FAF3 A9 11
        _XWR0                                   ; FAF5 00 10

        lda     SCRX                            ; FAF7 AD 20 02
        sta     VARAPL                          ; FAFA 85 D0
LFAFC:
        ; Attend une touche
        _XRDW0                                  ; FAFC 00 0C

        cmp     #KEY_RETURN                     ; FAFE C9 0D
        beq     LFB3A                           ; FB00 F0 38

        cmp     #KEY_DEL                        ; FB02 C9 7F
        bne     LFB14                           ; FB04 D0 0E

        lda     SCRX                            ; FB06 AD 20 02
        cmp     VARAPL                          ; FB09 C5 D0
        beq     LFAFC                           ; FB0B F0 EF

        ; "Affiche" un BS
        lda     #$08                            ; FB0D A9 08
        _XWR0                                   ; FB0F 00 10

        jmp     LFAFC                           ; FB11 4C FC FA

; ----------------------------------------------------------------------------
LFB14:
        cmp     #' '                            ; FB14 C9 20
        bcc     LFAFC                           ; FB16 90 E4

        beq     LFB2A                           ; FB18 F0 10

        cmp     #'0'                            ; FB1A C9 30
        bcc     LFAFC                           ; FB1C 90 DE

        cmp     #'9'+1                          ; FB1E C9 3A
        bcc     LFB2A                           ; FB20 90 08

        cmp     #'A'                            ; FB22 C9 41
        bcc     LFAFC                           ; FB24 90 D6

        cmp     #'Z'+1                          ; FB26 C9 5B
        bcs     LFAFC                           ; FB28 B0 D2

LFB2A:
        _XWR0                                   ; FB2A 00 10

        sec                                     ; FB2C 38
        lda     SCRX                            ; FB2D AD 20 02
        sbc     VARAPL                          ; FB30 E5 D0
        cmp     #$07                            ; FB32 C9 07
        bcc     LFAFC                           ; FB34 90 C6

        ; "Affiche" un BS
        lda     #$08                            ; FB36 A9 08
        _XWR0                                   ; FB38 00 10

LFB3A:
        lda     #$11                            ; FB3A A9 11
        _XWR0                                   ; FB3C 00 10

        ldy     VARAPL                          ; FB3E A4 D0
        sty     SCRX                            ; FB40 8C 20 02

        ; Prend un caractère à l'écran (C=1 si caractère alpha)
        jsr     LF97D                           ; FB43 20 7D F9
        bcs     LFB4C                           ; FB46 B0 04

        lda     #'X'                            ; FB48 A9 58
        sta     (ADSCR),y                       ; FB4A 91 26
LFB4C:
        ldx     #$F9                            ; FB4C A2 F9
        ldy     VARAPL                          ; FB4E A4 D0
LFB50:
        lda     (ADSCR),y                       ; FB50 B1 26
        sta     BUFEDT-$F9,x                    ; FB52 9D 97 04
        iny                                     ; FB55 C8
        inx                                     ; FB56 E8
        bne     LFB50                           ; FB57 D0 F7

        lda     RESB+1                          ; FB59 A5 03
        pha                                     ; FB5B 48
        lda     RESB                            ; FB5C A5 02
        pha                                     ; FB5E 48
        jsr     LE927                           ; FB5F 20 27 E9
        pla                                     ; FB62 68
        sta     RESB                            ; FB63 85 02
        pla                                     ; FB65 68
        sta     RESB+1                          ; FB66 85 03
        bcs     LFB8E                           ; FB68 B0 24

        ; Copie de 7 caractères de BUFEDT vers RESb
        ldy     #$07                            ; FB6A A0 07
LFB6C:
        lda     BUFEDT-1,y                      ; FB6C B9 8F 05
        sta     (RESB),y                        ; FB6F 91 02
        dey                                     ; FB71 88
        bne     LFB6C                           ; FB72 D0 F8

LFB74:
        jmp     LFA44                           ; FB74 4C 44 FA

; ----------------------------------------------------------------------------
; Insertion d'un page simple (blanche)?
LFB77:
        cmp     #'P'                            ; FB77 C9 50
        bne     LFB7F                           ; FB79 D0 04

        lda     #$00                            ; FB7B A9 00
        beq     LFB85                           ; FB7D F0 06

; ----------------------------------------------------------------------------
; Insertion d'un menu (cyan)?
LFB7F:
        cmp     #'S'                            ; FB7F C9 53
        bne     LFB95                           ; FB81 D0 12

        lda     #$C0                            ; FB83 A9 C0
LFB85:
        pha                                     ; FB85 48
        jsr     LFCD3                           ; FB86 20 D3 FC
        tay                                     ; FB89 A8
        pla                                     ; FB8A 68
        jsr     LF828                           ; FB8B 20 28 F8
LFB8E:
        ldx     $E6                             ; FB8E A6 E6
        lda     $E7                             ; FB90 A5 E7
        jmp     LF9C6                           ; FB92 4C C6 F9

; ----------------------------------------------------------------------------
; Retour sur la première page de l'arborescence?
LFB95:
        cmp     #'D'                            ; FB95 C9 44
        bne     LFB9F                           ; FB97 D0 06

        lda     #$00                            ; FB99 A9 00
        tax                                     ; FB9B AA
        jmp     LF9C6                           ; FB9C 4C C6 F9

; ----------------------------------------------------------------------------
; Suppression de la page?
LFB9F:
        cmp     #KEY_DEL                        ; FB9F C9 7F
        bne     LFBB6                           ; FBA1 D0 13

        ldy     SCRY                            ; FBA3 AC 24 02
        dey                                     ; FBA6 88
        beq     LFB74                           ; FBA7 F0 CB

        jsr     LFCD3                           ; FBA9 20 D3 FC
        jsr     LF6D5                           ; FBAC 20 D5 F6
LFBAF:
        ldx     $E6                             ; FBAF A6 E6
        lda     $E7                             ; FBB1 A5 E7
        jmp     LF9C6                           ; FBB3 4C C6 F9

; ----------------------------------------------------------------------------
; Insertion d'une BAL (verte)?
LFBB6:
        cmp     #'B'                            ; FBB6 C9 42
        bne     LFBBE                           ; FBB8 D0 04

        lda     #$41                            ; FBBA A9 41
        bne     LFB85                           ; FBBC D0 C7

; ----------------------------------------------------------------------------
; Insertion d'une page d'accès au basic (rouge)?
LFBBE:
        cmp     #'H'                            ; FBBE C9 48
        bne     LFBC6                           ; FBC0 D0 04

        lda     #$08                            ; FBC2 A9 08
        bne     LFB85                           ; FBC4 D0 BF

; ----------------------------------------------------------------------------
; Bascule de temporisation d'une page (jaune)?
LFBC6:
        cmp     #'A'                            ; FBC6 C9 41
        bne     LFC47                           ; FBC8 D0 7D

        jsr     LFCD3                           ; FBCA 20 D3 FC
        jsr     LE8AB                           ; FBCD 20 AB E8
        lda     PAGE+12                         ; FBD0 AD CC 9C
        and     #$89                            ; FBD3 29 89
        bne     LFC47                           ; FBD5 D0 70

        ldy     #$0C                            ; FBD7 A0 0C
        lda     PAGE+12                         ; FBD9 AD CC 9C
        eor     #$10                            ; FBDC 49 10
        sta     (RESB),y                        ; FBDE 91 02
        and     #$10                            ; FBE0 29 10
        beq     LFBAF                           ; FBE2 F0 CB

        ; place "    sec" à l'emplacement actuel du curseur
        ldx     #$00                            ; FBE4 A2 00
        ldy     SCRX                            ; FBE6 AC 20 02
LFBE9:
        lda     LF6BD,x                         ; FBE9 BD BD F6
        sta     (ADSCR),y                       ; FBEC 91 26
        iny                                     ; FBEE C8
        inx                                     ; FBEF E8
        cpx     #$07                            ; FBF0 E0 07
        bne     LFBE9                           ; FBF2 D0 F5

LFBF4:
        lda     #' '                            ; FBF4 A9 20
        sta     DEFAFF                          ; FBF6 85 14

        ; Calcule l'adresse de l'emplacement du curseur à l'écran
        ; et place le résultat en TR5-TR6 (pour XBINDX)
        clc                                     ; FBF8 18
        lda     SCRX                            ; FBF9 AD 20 02
        adc     ADSCR                           ; FBFC 65 26
        sta     TR5                             ; FBFE 85 11
        lda     ADSCR+1                         ; FC00 A5 27
        adc     #$00                            ; FC02 69 00
        sta     TR6                             ; FC04 85 12

        ; Converti (RESB),Y en chaine sur 3 caractères
        ; et place le résultat en (TR6)
        ; soit devant "sec"
        ldy     #$0D                            ; FC06 A0 0D
        lda     (RESB),y                        ; FC08 B1 02
        ldy     #$00                            ; FC0A A0 00
        ldx     #$01                            ; FC0C A2 01
        _XBINDX                                 ; FC0E 00 28

        ; Attend une touche
        _XRDW0                                  ; FC10 00 0C

        ldy     #$0D                            ; FC12 A0 0D
        cmp     #'0'                            ; FC14 C9 30
        bne     LFC1E                           ; FC16 D0 06

        ; Place 0 en (RESB),Y et boucle
        lda     #$00                            ; FC18 A9 00
        sta     (RESB),y                        ; FC1A 91 02
        beq     LFBF4                           ; FC1C F0 D6

; ----------------------------------------------------------------------------
; Incrémente ou décrémente (RESB),Y si KEY_UP ou KEY_DOWN
;
; Entrée:
;    A: Touche appuyée
;
; Sortie:
;    Incrémente (RESB),Y si KEY_UP
;    Décrémente (RESB),Y si KEY_DOWN

LFC1E:
        ldx     #$FE                            ; FC1E A2 FE
        cmp     #KEY_DOWN                       ; FC20 C9 0A
        beq     LFC2A                           ; FC22 F0 06

        cmp     #KEY_UP                         ; FC24 C9 0B
        bne     LFC32                           ; FC26 D0 0A

        ldx     #$00                            ; FC28 A2 00
LFC2A:
        ; Dans tous les cas, ici C=1
        ; Donc on décrémente si KEY_DOWN ($FE+1 = $FF)
        ; et on incrémente de KEY_UP ($00+1 = $01)
        txa                                     ; FC2A 8A
        adc     (RESB),y                        ; FC2B 71 02
        sta     (RESB),y                        ; FC2D 91 02

        ; Boucle
        jmp     LFBF4                           ; FC2F 4C F4 FB

; ----------------------------------------------------------------------------
LFC32:
        ; Copie et inverse 8 caractères depuis L9CC1 vers l'écran
        ; à l'emplacement actuel du curseur
        ldx     #$01                            ; FC32 A2 01
        ldy     SCRX                            ; FC34 AC 20 02
LFC37:
        lda     PAGE,x                          ; FC37 BD C0 9C
        ora     #$80                            ; FC3A 09 80
        sta     (ADSCR),y                       ; FC3C 91 26
        iny                                     ; FC3E C8
        inx                                     ; FC3F E8
        cpx     #$08                            ; FC40 E0 08
        bne     LFC37                           ; FC42 D0 F3

        jmp     LFBAF                           ; FC44 4C AF FB

; ----------------------------------------------------------------------------
; Bascule de fin de branche visible (carré blanc)?
LFC47:
        cmp     #'F'                            ; FC47 C9 46
        bne     LFC7B                           ; FC49 D0 30

        jsr     LFCD3                           ; FC4B 20 D3 FC
        jsr     LE8AB                           ; FC4E 20 AB E8
        bit     PAGE                            ; FC51 2C C0 9C
        bvs     LFC78                           ; FC54 70 22

        ldy     #$0C                            ; FC56 A0 0C
        lda     (RESB),y                        ; FC58 B1 02
        eor     #$02                            ; FC5A 49 02
        sta     (RESB),y                        ; FC5C 91 02
        tax                                     ; FC5E AA
        ldy     SCRX                            ; FC5F AC 20 02
        dey                                     ; FC62 88
        lda     (ADSCR),y                       ; FC63 B1 26
        pha                                     ; FC65 48
        txa                                     ; FC66 8A
        and     #$02                            ; FC67 29 02
        beq     LFC73                           ; FC69 F0 08

        pla                                     ; FC6B 68
        ora     #$80                            ; FC6C 09 80
        sta     (ADSCR),y                       ; FC6E 91 26
        jmp     LFA44                           ; FC70 4C 44 FA

; ----------------------------------------------------------------------------
LFC73:
        pla                                     ; FC73 68
        and     #$7F                            ; FC74 29 7F
        sta     (ADSCR),y                       ; FC76 91 26
LFC78:
        jmp     LFA44                           ; FC78 4C 44 FA

; ----------------------------------------------------------------------------
; Insertion de la tête d'un journal cyclique (magenta)
LFC7B:
        cmp     #'J'                            ; FC7B C9 4A
        bne     LFC84                           ; FC7D D0 05

        lda     #$04                            ; FC7F A9 04
        jmp     LFB85                           ; FC81 4C 85 FB

; ----------------------------------------------------------------------------
; Choix du lecteur de disques?
LFC84:
        cmp     #'L'                            ; FC84 C9 4C
        bne     LFCC3                           ; FC86 D0 3B

        jsr     LFCD3                           ; FC88 20 D3 FC
        jsr     LE8AB                           ; FC8B 20 AB E8

        ; Sauvegarde le caractère précédent le curseur à l'écran
        ldy     SCRX                            ; FC8E AC 20 02
        dey                                     ; FC91 88
        lda     (ADSCR),y                       ; FC92 B1 26
        pha                                     ; FC94 48

        ; Récupère le lecteur courant et l'affiche
        ; à l'emplacement du curseur
        lda     $9CCF                           ; FC95 AD CF 9C
        asl     a                               ; FC98 0A
        rol     a                               ; FC99 2A
        rol     a                               ; FC9A 2A
        and     #$03                            ; FC9B 29 03
        adc     #'A'                            ; FC9D 69 41
        sta     (ADSCR),y                       ; FC9F 91 26

LFCA1:
        ; Attend une touche
        _XRDW0                                  ; FCA1 00 0C

        cmp     #'A'                            ; FCA3 C9 41
        bcc     LFCBD                           ; FCA5 90 16

        cmp     #'E'                            ; FCA7 C9 45
        bcs     LFCBD                           ; FCA9 B0 12

        ; Ici 'A', 'B', 'C', 'D'

        ; Affiche le caractère
        sta     (ADSCR),y                       ; FCAB 91 26

        ; Code le n° de lecteur dans b7-b6
        ; et le sauvegarde en (RESB),$0F
        sbc     #$40                            ; FCAD E9 40
        lsr     a                               ; FCAF 4A
        ror     a                               ; FCB0 6A
        ror     a                               ; FCB1 6A
        ldy     #$0F                            ; FCB2 A0 0F
        sta     (RESB),y                        ; FCB4 91 02

        ; 1 caractère en arrière
        ldy     SCRX                            ; FCB6 AC 20 02
        dey                                     ; FCB9 88

        ; Boucle
        jmp     LFCA1                           ; FCBA 4C A1 FC

; ----------------------------------------------------------------------------
LFCBD:
        ; Restaure le caractère sauvegardé en LFC94
        pla                                     ; FCBD 68
        sta     (ADSCR),y                       ; FCBE 91 26

        ; Sortie
        jmp     LFA44                           ; FCC0 4C 44 FA

; ----------------------------------------------------------------------------
; Accès direct au menu d'accès disque?
LFCC3:
        cmp     #KEY_CTRL_E                     ; FCC3 C9 05
        bne     LFCD0                           ; FCC5 D0 09

        ; Calcule l'adresse de fin de l'arborescence ainsi que le nombre de pages
        ; et met à jour DESALO et FISALO
        jsr     LF98F                           ; FCC7 20 8F F9

        ; -> ACCES DISQUE SERVEUR
        ; (au retour X=0)
        jsr     LE17F                           ; FCCA 20 7F E1

        ; Comme X=0 -> edition du serveur
        jmp     LF9BC                           ; FCCD 4C BC F9

; ----------------------------------------------------------------------------
LFCD0:
        jmp     LFA44                           ; FCD0 4C 44 FA

; ----------------------------------------------------------------------------
; Copie les 6 caractères du mot clé à l'écran vers BUFEDT
; puis recherche ce mot dans la table des mots clé
LFCD3:
        ldx     #$00                            ; FCD3 A2 00
        ldy     SCRX                            ; FCD5 AC 20 02
LFCD8:
        lda     (ADSCR),y                       ; FCD8 B1 26
        and     #$7F                            ; FCDA 29 7F
        sta     BUFEDT,x                        ; FCDC 9D 90 05
        iny                                     ; FCDF C8
        inx                                     ; FCE0 E8
        cpx     #$07                            ; FCE1 E0 07
        bne     LFCD8                           ; FCE3 D0 F3

        jmp     LE927                           ; FCE5 4C 27 E9

; ----------------------------------------------------------------------------
LFCE8:
        bit     VARAPL+14                       ; FCE8 24 DE
        bpl     LFCF3                           ; FCEA 10 07

        _XLPCRL                                 ; FCEC 00 49
        _XLPCRL                                 ; FCEE 00 49
        jmp     LFCF7                           ; FCF0 4C F7 FC

; ----------------------------------------------------------------------------
LFCF3:
        lda     #$0C                            ; FCF3 A9 0C
        _XWR0                                   ; FCF5 00 10

LFCF7:
        ldx     #$3F                            ; FCF7 A2 3F
        lda     #$00                            ; FCF9 A9 00
LFCFB:
        sta     $9D80,x                         ; FCFB 9D 80 9D
        dex                                     ; FCFE CA
        bpl     LFCFB                           ; FCFF 10 FA

LFD01:
        ldy     #$7F                            ; FD01 A0 7F
        lda     #$20                            ; FD03 A9 20
LFD05:
        sta     $9D00,y                         ; FD05 99 00 9D
        dey                                     ; FD08 88
        bpl     LFD05                           ; FD09 10 FA

        lda     #$89                            ; FD0B A9 89
        sta     $9D00                           ; FD0D 8D 00 9D
        ldx     #$0F                            ; FD10 A2 0F
LFD12:
        lsr     $9DB0,x                         ; FD12 5E B0 9D
        dex                                     ; FD15 CA
        bpl     LFD12                           ; FD16 10 FA

        rts                                     ; FD18 60

; ----------------------------------------------------------------------------
LFD19:
        bit     VARAPL+14                       ; FD19 24 DE
        bpl     LFD3B                           ; FD1B 10 1E

        sty     VARAPL+12                       ; FD1D 84 DC
        pha                                     ; FD1F 48
        cmp     #$80                            ; FD20 C9 80
        bcs     LFD33                           ; FD22 B0 0F

        cmp     #$60                            ; FD24 C9 60
        bcc     LFD35                           ; FD26 90 0D

        cmp     #$69                            ; FD28 C9 69
        bcs     LFD35                           ; FD2A B0 09

        and     #$0F                            ; FD2C 29 0F
        tay                                     ; FD2E A8
        lda     LFD3E,y                         ; FD2F B9 3E FD
        .byte   $2C                             ; FD32 2C

LFD33:
        lda     #$20                            ; FD33 A9 20
LFD35:
        _XLPRBI                                 ; FD35 00 48
        ldy     VARAPL+12                       ; FD37 A4 DC
        pla                                     ; FD39 68
        rts                                     ; FD3A 60

; ----------------------------------------------------------------------------
LFD3B:
        _XWR0                                   ; FD3B 00 10
        rts                                     ; FD3D 60

; ----------------------------------------------------------------------------
LFD3E:
        .byte   $21,$2F,$5C,$5E,$2B,$2D,$2B,$2B ; FD3E 21 2F 5C 5E 2B 2D 2B 2B
        .byte   $2B                             ; FD46 2B
; ----------------------------------------------------------------------------
LFD47:
        lda     VARAPL+10                       ; FD47 A5 DA
        sta     VARAPL+7                        ; FD49 85 D7
        lda     #$00                            ; FD4B A9 00
        sta     VARAPL+8                        ; FD4D 85 D8
LFD4F:
        ldx     VARAPL+8                        ; FD4F A6 D8
        lda     $9D90,x                         ; FD51 BD 90 9D
        bpl     LFDA8                           ; FD54 10 52

        and     #$7F                            ; FD56 29 7F
        sta     RESB+1                          ; FD58 85 03
        lda     $9D80,x                         ; FD5A BD 80 9D
        sta     RESB                            ; FD5D 85 02
        ldy     #$0C                            ; FD5F A0 0C
        ldx     #$86                            ; FD61 A2 86
        lda     (RESB),y                        ; FD63 B1 02
        bmi     LFD7E                           ; FD65 30 17

        ldx     #$82                            ; FD67 A2 82
        lsr     a                               ; FD69 4A
        bcs     LFD7E                           ; FD6A B0 12

        ldx     #$85                            ; FD6C A2 85
        lsr     a                               ; FD6E 4A
        lsr     a                               ; FD6F 4A
        bcs     LFD7E                           ; FD70 B0 0C

        ldx     #$81                            ; FD72 A2 81
        lsr     a                               ; FD74 4A
        bcs     LFD7E                           ; FD75 B0 07

        ldx     #$83                            ; FD77 A2 83
        lsr     a                               ; FD79 4A
        bcs     LFD7E                           ; FD7A B0 02

        ldx     #$87                            ; FD7C A2 87
LFD7E:
        txa                                     ; FD7E 8A
        jsr     LFD19                           ; FD7F 20 19 FD
        ldy     #$0C                            ; FD82 A0 0C
        lda     (RESB),y                        ; FD84 B1 02
        and     #$02                            ; FD86 29 02
        beq     LFD94                           ; FD88 F0 0A

        ldy     SCRX                            ; FD8A AC 20 02
        dey                                     ; FD8D 88
        lda     (ADSCR),y                       ; FD8E B1 26
        ora     #$80                            ; FD90 09 80
        sta     (ADSCR),y                       ; FD92 91 26
LFD94:
        ldy     #$01                            ; FD94 A0 01
        ldx     #$07                            ; FD96 A2 07
LFD98:
        lda     (RESB),y                        ; FD98 B1 02
        jsr     LFD19                           ; FD9A 20 19 FD
        iny                                     ; FD9D C8
        dex                                     ; FD9E CA
        bne     LFD98                           ; FD9F D0 F7

LFDA1:
        inc     VARAPL+8                        ; FDA1 E6 D8
        dec     VARAPL+7                        ; FDA3 C6 D7
        bne     LFD4F                           ; FDA5 D0 A8

        rts                                     ; FDA7 60

; ----------------------------------------------------------------------------
LFDA8:
        lda     #$90                            ; FDA8 A9 90
        jsr     LFD19                           ; FDAA 20 19 FD
        ldx     #$07                            ; FDAD A2 07
LFDAF:
        jsr     LFD19                           ; FDAF 20 19 FD
        dex                                     ; FDB2 CA
        bne     LFDAF                           ; FDB3 D0 FA

        beq     LFDA1                           ; FDB5 F0 EA

LFDB7:
        sta     $E7                             ; FDB7 85 E7
        stx     $E6                             ; FDB9 86 E6
        jsr     LE8AB                           ; FDBB 20 AB E8
        lda     #$00                            ; FDBE A9 00
        pha                                     ; FDC0 48
LFDC1:
        jsr     LFCE8                           ; FDC1 20 E8 FC
        lda     VARAPL+9                        ; FDC4 A5 D9
        lsr     a                               ; FDC6 4A
        lsr     a                               ; FDC7 4A
        lsr     a                               ; FDC8 4A
        sta     VARAPL+10                       ; FDC9 85 DA
        lsr     a                               ; FDCB 4A
        pha                                     ; FDCC 48
        lda     VARAPL+11                       ; FDCD A5 DB
        sta     VARAPL+13                       ; FDCF 85 DD
        pla                                     ; FDD1 68
        tax                                     ; FDD2 AA
        lda     RESB                            ; FDD3 A5 02
        sta     $9D80,x                         ; FDD5 9D 80 9D
        lda     RESB+1                          ; FDD8 A5 03
        ora     #$80                            ; FDDA 09 80
        sta     $9D90,x                         ; FDDC 9D 90 9D

LFDDF:
        jsr     LFD47                           ; FDDF 20 47 FD
        lda     #$00                            ; FDE2 A9 00
        sta     VARAPL+15                       ; FDE4 85 DF
LFDE6:
        ldx     VARAPL+15                       ; FDE6 A6 DF
        lda     $9D90,x                         ; FDE8 BD 90 9D
        bpl     LFE25                           ; FDEB 10 38

        and     #$7F                            ; FDED 29 7F
        sta     RESB+1                          ; FDEF 85 03
        lda     $9D80,x                         ; FDF1 BD 80 9D
        sta     RESB                            ; FDF4 85 02
        ldy     #$0C                            ; FDF6 A0 0C
        lda     (RESB),y                        ; FDF8 B1 02
        bmi     LFE14                           ; FDFA 30 18

        and     #$40                            ; FDFC 29 40
        bne     LFE25                           ; FDFE D0 25

        ldy     #$08                            ; FE00 A0 08
        lda     (RESB),y                        ; FE02 B1 02
        tax                                     ; FE04 AA
        iny                                     ; FE05 C8
        lda     (RESB),y                        ; FE06 B1 02
        jsr     LE8AB                           ; FE08 20 AB E8
        lda     RESB                            ; FE0B A5 02
        ldx     VARAPL+15                       ; FE0D A6 DF
        sta     $9DA0,x                         ; FE0F 9D A0 9D
        lda     RESB+1                          ; FE12 A5 03
LFE14:
        ora     #$80                            ; FE14 09 80
        sta     $9DB0,x                         ; FE16 9D B0 9D
        txa                                     ; FE19 8A
        asl     a                               ; FE1A 0A
        asl     a                               ; FE1B 0A
        asl     a                               ; FE1C 0A
        adc     #$04                            ; FE1D 69 04
        tax                                     ; FE1F AA
        lda     #$60                            ; FE20 A9 60
        sta     $9D00,x                         ; FE22 9D 00 9D
LFE25:
        inc     VARAPL+15                       ; FE25 E6 DF
        lda     VARAPL+15                       ; FE27 A5 DF
        cmp     VARAPL+10                       ; FE29 C5 DA
        bne     LFDE6                           ; FE2B D0 B9

        lda     #$00                            ; FE2D A9 00
        sta     VARAPL+15                       ; FE2F 85 DF
LFE31:
        ldx     VARAPL+15                       ; FE31 A6 DF
        lda     $9D90,x                         ; FE33 BD 90 9D
        bmi     LFE3B                           ; FE36 30 03

LFE38:
        jmp     LFF68                           ; FE38 4C 68 FF

; ----------------------------------------------------------------------------
LFE3B:
        and     #$7F                            ; FE3B 29 7F
        sta     VARAPL+5                        ; FE3D 85 D5
        lda     $9D80,x                         ; FE3F BD 80 9D
        sta     VARAPL+4                        ; FE42 85 D4
        ldy     #$0C                            ; FE44 A0 0C
        lda     (VARAPL+4),y                    ; FE46 B1 D4
        bpl     LFE38                           ; FE48 10 EE

        ldy     #$FF                            ; FE4A A0 FF
LFE4C:
        iny                                     ; FE4C C8
        dex                                     ; FE4D CA
        bmi     LFE55                           ; FE4E 30 05

        lda     $9DB0,x                         ; FE50 BD B0 9D
        bpl     LFE4C                           ; FE53 10 F7

LFE55:
        sty     VARAPL                          ; FE55 84 D0
        inx                                     ; FE57 E8
        stx     VARAPL+1                        ; FE58 86 D1
        ldy     #$00                            ; FE5A A0 00
        ldx     VARAPL+15                       ; FE5C A6 DF
LFE5E:
        iny                                     ; FE5E C8
        inx                                     ; FE5F E8
        cpx     VARAPL+10                       ; FE60 E4 DA
        bcs     LFE69                           ; FE62 B0 05

        lda     $9DB0,x                         ; FE64 BD B0 9D
        bpl     LFE5E                           ; FE67 10 F5

LFE69:
        clc                                     ; FE69 18
        tya                                     ; FE6A 98
        adc     VARAPL                          ; FE6B 65 D0
        sta     VARAPL+2                        ; FE6D 85 D2
        ldy     #$0D                            ; FE6F A0 0D
        lda     (VARAPL+4),y                    ; FE71 B1 D4
        bne     LFE7A                           ; FE73 D0 05

        ldx     VARAPL+15                       ; FE75 A6 DF
        lsr     $9DB0,x                         ; FE77 5E B0 9D
LFE7A:
        cmp     VARAPL+2                        ; FE7A C5 D2
        beq     LFEA9                           ; FE7C F0 2B

        bcc     LFEA9                           ; FE7E 90 29

        lda     VARAPL+15                       ; FE80 A5 DF
        asl     a                               ; FE82 0A
        asl     a                               ; FE83 0A
        asl     a                               ; FE84 0A
        adc     #$03                            ; FE85 69 03
        tax                                     ; FE87 AA
        lda     #$65                            ; FE88 A9 65
        sta     $9D00,x                         ; FE8A 9D 00 9D
        sta     $9D02,x                         ; FE8D 9D 02 9D
        lda     #$68                            ; FE90 A9 68
        sta     $9D01,x                         ; FE92 9D 01 9D
        ldx     VARAPL+15                       ; FE95 A6 DF
        lda     #$FF                            ; FE97 A9 FF
        sta     $9DB0,x                         ; FE99 9D B0 9D
        bit     VARAPL+14                       ; FE9C 24 DE
        bpl     LFEA6                           ; FE9E 10 06

        lda     VARAPL+4                        ; FEA0 A5 D4
        pha                                     ; FEA2 48
        lda     VARAPL+5                        ; FEA3 A5 D5
        pha                                     ; FEA5 48
LFEA6:
        jmp     LFF68                           ; FEA6 4C 68 FF

; ----------------------------------------------------------------------------
LFEA9:
        sta     VARAPL                          ; FEA9 85 D0
        tax                                     ; FEAB AA
        beq     LFEA6                           ; FEAC F0 F8

        lda     VARAPL+2                        ; FEAE A5 D2
        ldx     #$FF                            ; FEB0 A2 FF
LFEB2:
        inx                                     ; FEB2 E8
        sec                                     ; FEB3 38
        sbc     VARAPL                          ; FEB4 E5 D0
        bcs     LFEB2                           ; FEB6 B0 FA

        stx     VARAPL+3                        ; FEB8 86 D3
        ldx     VARAPL                          ; FEBA A6 D0
        lda     VARAPL+2                        ; FEBC A5 D2
        clc                                     ; FEBE 18
        dex                                     ; FEBF CA
        beq     LFEC7                           ; FEC0 F0 05

LFEC2:
        sbc     VARAPL+3                        ; FEC2 E5 D3
        dex                                     ; FEC4 CA
        bne     LFEC2                           ; FEC5 D0 FB

LFEC7:
        lsr     a                               ; FEC7 4A
        clc                                     ; FEC8 18
        adc     VARAPL+1                        ; FEC9 65 D1
        sta     VARAPL+1                        ; FECB 85 D1
        sec                                     ; FECD 38
        ror     $E0                             ; FECE 66 E0
        asl     a                               ; FED0 0A
        asl     a                               ; FED1 0A
        asl     a                               ; FED2 0A
        adc     #$04                            ; FED3 69 04
        sta     VARAPL+8                        ; FED5 85 D8
        ldx     VARAPL+15                       ; FED7 A6 DF
        lsr     $9DB0,x                         ; FED9 5E B0 9D
        ldy     #$10                            ; FEDC A0 10
        sty     VARAPL+6                        ; FEDE 84 D6
LFEE0:
        ldy     VARAPL+6                        ; FEE0 A4 D6
        lda     (VARAPL+4),y                    ; FEE2 B1 D4
        tax                                     ; FEE4 AA
        iny                                     ; FEE5 C8
        lda     (VARAPL+4),y                    ; FEE6 B1 D4
        jsr     LE8AB                           ; FEE8 20 AB E8
        ldx     VARAPL+1                        ; FEEB A6 D1
        lda     RESB                            ; FEED A5 02
        sta     $9DA0,x                         ; FEEF 9D A0 9D
        lda     RESB+1                          ; FEF2 A5 03
        ora     #$80                            ; FEF4 09 80
        sta     $9DB0,x                         ; FEF6 9D B0 9D
        inc     VARAPL+6                        ; FEF9 E6 D6
        inc     VARAPL+6                        ; FEFB E6 D6
        bit     $E0                             ; FEFD 24 E0
        bpl     LFF1E                           ; FEFF 10 1D

        ldx     VARAPL                          ; FF01 A6 D0
        dex                                     ; FF03 CA
        bne     LFF09                           ; FF04 D0 03

        jmp     LFF68                           ; FF06 4C 68 FF

; ----------------------------------------------------------------------------
LFF09:
        ldx     VARAPL+8                        ; FF09 A6 D8
        inc     VARAPL+8                        ; FF0B E6 D8
        ldy     #$67                            ; FF0D A0 67
        lda     $9D00,x                         ; FF0F BD 00 9D
        cmp     #$60                            ; FF12 C9 60
        beq     LFF18                           ; FF14 F0 02

        ldy     #$61                            ; FF16 A0 61
LFF18:
        lsr     $E0                             ; FF18 46 E0
        tya                                     ; FF1A 98
        sta     $9D00,x                         ; FF1B 9D 00 9D
LFF1E:
        ldx     VARAPL                          ; FF1E A6 D0
        dex                                     ; FF20 CA
        bne     LFF5A                           ; FF21 D0 37

        lda     VARAPL+1                        ; FF23 A5 D1
        asl     a                               ; FF25 0A
        asl     a                               ; FF26 0A
        asl     a                               ; FF27 0A
        adc     #$06                            ; FF28 69 06
        sbc     VARAPL+8                        ; FF2A E5 D8
        tay                                     ; FF2C A8
        ldx     VARAPL+8                        ; FF2D A6 D8
LFF2F:
        dey                                     ; FF2F 88
        beq     LFF4B                           ; FF30 F0 19

        lda     $9D00,x                         ; FF32 BD 00 9D
        cmp     #$20                            ; FF35 C9 20
        beq     LFF40                           ; FF37 F0 07

        cmp     #$60                            ; FF39 C9 60
        beq     LFF43                           ; FF3B F0 06

        lda     #$64                            ; FF3D A9 64
        .byte   $2C                             ; FF3F 2C
LFF40:
        lda     #$65                            ; FF40 A9 65
        .byte   $2C                             ; FF42 2C
LFF43:
        lda     #$68                            ; FF43 A9 68
        sta     $9D00,x                         ; FF45 9D 00 9D
        inx                                     ; FF48 E8
        bne     LFF2F                           ; FF49 D0 E4

LFF4B:
        ldy     #$66                            ; FF4B A0 66
        lda     $9D00,x                         ; FF4D BD 00 9D
        cmp     #$20                            ; FF50 C9 20
        bne     LFF56                           ; FF52 D0 02

        ldy     #$62                            ; FF54 A0 62
LFF56:
        tya                                     ; FF56 98
        sta     $9D00,x                         ; FF57 9D 00 9D
LFF5A:
        clc                                     ; FF5A 18
        lda     VARAPL+1                        ; FF5B A5 D1
        adc     VARAPL+3                        ; FF5D 65 D3
        sta     VARAPL+1                        ; FF5F 85 D1
        dec     VARAPL                          ; FF61 C6 D0
        beq     LFF68                           ; FF63 F0 03

        jmp     LFEE0                           ; FF65 4C E0 FE

; ----------------------------------------------------------------------------
LFF68:
        inc     VARAPL+15                       ; FF68 E6 DF
        lda     VARAPL+15                       ; FF6A A5 DF
        cmp     VARAPL+10                       ; FF6C C5 DA
        beq     LFF73                           ; FF6E F0 03

        jmp     LFE31                           ; FF70 4C 31 FE

; ----------------------------------------------------------------------------
LFF73:
        ldx     #$1F                            ; FF73 A2 1F
LFF75:
        lda     $9DA0,x                         ; FF75 BD A0 9D
        cmp     #$FF                            ; FF78 C9 FF
        bne     LFF81                           ; FF7A D0 05

        cpx     #$10                            ; FF7C E0 10
        bcc     LFF81                           ; FF7E 90 01

        txa                                     ; FF80 8A
LFF81:
        sta     $9D80,x                         ; FF81 9D 80 9D
        dex                                     ; FF84 CA
        bpl     LFF75                           ; FF85 10 EE

        ldx     #$00                            ; FF87 A2 00
LFF89:
        lda     $9D00,x                         ; FF89 BD 00 9D
        jsr     LFD19                           ; FF8C 20 19 FD
        inx                                     ; FF8F E8
        cpx     VARAPL+9                        ; FF90 E4 D9
        bne     LFF89                           ; FF92 D0 F5

        jsr     LFD01                           ; FF94 20 01 FD
        dec     VARAPL+13                       ; FF97 C6 DD
        beq     LFFA5                           ; FF99 F0 0A

        ldx     #$0F                            ; FF9B A2 0F
LFF9D:
        lda     $9D90,x                         ; FF9D BD 90 9D
        bmi     LFFB2                           ; FFA0 30 10

        dex                                     ; FFA2 CA
        bpl     LFF9D                           ; FFA3 10 F8

LFFA5:
        pla                                     ; FFA5 68
        beq     LFFB1                           ; FFA6 F0 09

        sta     RESB+1                          ; FFA8 85 03
        tax                                     ; FFAA AA
        pla                                     ; FFAB 68
        sta     RESB                            ; FFAC 85 02
        jmp     LFDC1                           ; FFAE 4C C1 FD

; ----------------------------------------------------------------------------
LFFB1:
        rts                                     ; FFB1 60

; ----------------------------------------------------------------------------
LFFB2:
        jmp     LFDDF                           ; FFB2 4C DF FD

; ----------------------------------------------------------------------------
        .byte   $00,$00,$00,$00                 ; FFB5 00 00 00 00
; ----------------------------------------------------------------------------
; Saisir un caractère dans A
XTGET:
        jmp     _XTGET                          ; FFB9 4C 72 EC

; ----------------------------------------------------------------------------
; Point d'entrée pour l'instruction Hyperbasic 'TINPUT'
XTINPU:
        jmp     _XTINPUT                        ; FFBC 4C CC EC

; ----------------------------------------------------------------------------
; Point d'entrée pour l'instruction Hyperbasic 'APLIC'
XAPLIC:
        jmp     _XAPLIC                         ; FFBF 4C 45 E0

; ----------------------------------------------------------------------------
; Lancer le codage de la page courante avec les paramètres courants
XTVDTEX:
        jmp     _XVDTEX                         ; FFC2 4C EC F2

; ----------------------------------------------------------------------------
; Point d'entrée pour l'instruction Hyperbasic 'SERVEUR'
;
; Entrée;
;    X: mode de fonctionnement du serveur
;        0 -> "Lancer le serveur"
;        1 -> "Tester le serveur"
;        2 -> "Borne de communication"
;        3 -> "Tester sans acces disque"
XSERVE:
        jmp     _XSERVE                         ; FFC5 4C A6 E4

; ----------------------------------------------------------------------------
ROMSIG:
        .byte   "TELEMATIC V2.0b"               ; FFC8 54 45 4C 45 4D 41 54 49
                                                ; FFD0 43 20 56 32 2E 30 62
        .byte   $0A,$0D                         ; FFD7 0A 0D
        .byte   "(c) 1986 ORIC International"   ; FFD9 28 63 29 20 31 39 38 36
                                                ; FFE1 20 4F 52 49 43 20 49 6E
                                                ; FFE9 74 65 72 6E 61 74 69 6F
                                                ; FFF1 6E 61 6C
        .byte   $0D,$0A,$0A,$00                 ; FFF4 0D 0A 0A 00
; ----------------------------------------------------------------------------
SIG_vector:
        .addr   ROMSIG                          ; FFF8 C8 FF

NMI_vector:
        .addr   LE713                           ; FFFA 13 E7

RST_vector:
        .addr   LE000                           ; FFFC 00 E0

IRQ_vector:
        .addr   VIRQ                            ; FFFE FA 02
