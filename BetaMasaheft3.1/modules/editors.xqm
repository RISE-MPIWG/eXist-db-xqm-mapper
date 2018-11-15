xquery version "3.1" encoding "UTF-8";
(:~
 : module used by text search query functions to provide alternative 
 : strings to the search, based on known homophones.
 : 
 : @author Pietro Liuzzo <pietro.liuzzo@uni-hamburg.de'>
 :)
module namespace editors = "https://www.betamasaheft.uni-hamburg.de/BetMas/editors";
declare namespace test="http://exist-db.org/xquery/xqsuite";

(:~gets the name of the editor given the initials:)
declare
%test:arg("key", "PL") %test:assertEquals('Pietro Maria Liuzzo')
function editors:editorKey($key as xs:string){
switch ($key)
                        case "ES" return 'Eugenia Sokolinski'
                        case "DN" return 'Denis Nosnitsin'
                        case "MV" return 'Massimo Villa'
                        case "DR" return 'Dorothea Reule'
                        case "SG" return 'Solomon Gebreyes'
                        case "PL" return 'Pietro Maria Liuzzo'
                        case "SA" return 'Stéphane Ancel'
                        case "SD" return 'Sophia Dege'
                        case "VP" return 'Vitagrazia Pisani'
                        case "IF" return 'Iosif Fridman'
                        case "SH" return 'Susanne Hummel'
                        case "FP" return 'Francesca Panini'
                        case "DE" return 'Daria Elagina'
                        case "MK" return 'Magdalena Krzyzanowska'
                        case "VR" return 'Veronika Roth'
                        case "AA" return 'Abreham Adugna'
                        case "EG" return 'Ekaterina Gusarova'
                        case "IR" return 'Irene Roticiani'
                        case "MB" return 'Maria Bulakh'
                        case "NV" return 'Nafisa Valieva'
                        case "RHC" return 'Ran HaCohen'
                        case "SS" return 'Sisay Sahile'
                        case 'JG' return 'Jacopo Gnisci'
                        case 'MP' return 'Michele Petrone'
                        case 'JK' return 'Jonas Karlsson'
                       case 'EDS' return 'Eliana Dal Sasso'
                                case 'SF' return 'Sara Fani'
                                case 'IP' return 'Irmeli Perho'
                                case 'RBO' return 'Rasmus Bech Olsen'
                                case 'AR' return 'Anne Regourd'
                                case 'AH' return 'Adday Hernández'
                                case 'JSa' return 'Joshua Sabih'
                                case 'AW' return 'Andreas Wetter'
                                case 'JML' return 'John Møller Larsen'
                        case 'AG' return 'Alessandro Gori'
                        case 'SJ' return 'Sibylla Jenner'
                        case 'AWi' return 'Anaïs Wion'
                        case 'ABr' return 'Antonella Brita'
                                case 'SD' return 'Steve Delamarter'
                                case 'RL' return 'Ralph Lee'
                                case 'JS' return 'Jonah Sandford'
                                case 'CH' return 'Carsten Hoffmann'
                                case 'AE' return 'Andreas Ellwardt'
                                case 'WD' return 'Wolfgang Dickhut'
                                case 'HE' return 'Hiruie Ermias'

                        default return 'Alessandro Bausi'};


        (:~ given the user name, returns the initials:)
declare function editors:editorNames($key as xs:string){
switch ($key)
                        case 'Eugenia'return "ES" 
                        case 'Denis'return "DN" 
                        case 'Massimo'return "MV" 
                        case 'Dorothea'return "DR" 
                        case 'Solomon'return "SG" 
                        case 'Pietro'return "PL" 
                         case 'Francesca'return "FP" 
                        case 'Daria'return "DE" 
                        case 'Magdalena'return "MK" 
                       case 'Ran'return "RHC" 
                        case 'Sisay'return "SS" 
                        case 'Sibylla'return "SJ" 
                        case 'Jacopo' return 'JG'
                        case 'Nafisa' return 'NV'
                        case 'Michele' return 'MP'
                        case 'Eliana' return 'EDS'
                                case 'Sara' return 'SF'
                                case 'Irmeli' return 'IP'
                                case 'Alessandro' return 'AG'
                                case 'Rasmus' return 'RBO'
                                case 'Anne' return 'AR'
                                case 'Adday ' return 'AH'
                                case 'Joshua' return 'JS'
                                case 'Andreas' return 'AW'
                                case 'John' return 'JML'
                                case 'Jonas' return 'JK'
                                case 'Anaïs' return 'AWi'
                                case 'Steve' return 'SD'
                                case 'Ralph' return 'RL'
                                case 'Jonah' return 'JS'
                                case 'Carsten' return 'CH'
                                case 'Antonella' return 'ABr'
                                
                                
                        default return 'AB'};