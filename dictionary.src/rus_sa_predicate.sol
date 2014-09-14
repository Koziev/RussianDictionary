// *****************
// СКАЗУЕМОЕ
// *****************


// -------------------
// НАСТОЯЩЕЕ ВРЕМЯ
// -------------------

// кот спит
pattern Сказуемое0
{
 v=ГлНаст:export{ ЛИЦО ЧИСЛО РОД ВРЕМЯ node:root_node }
 p=@optional(ДеепрИнфОборот)
} : links { v.~<ADV_PARTICIPLE>p }

// кот, свернувшись клубком, спит
pattern Сказуемое0
{
 p=ДеепрИнфОборотПеред
 v=ГлНаст:export{ ЛИЦО ЧИСЛО РОД ВРЕМЯ node:root_node }
} : links { v.<ADV_PARTICIPLE>p }


// Компаратив как часть сказуемого в настоящем времени:
// день становится короче
pattern Сказуемое0
{
 adv=@optional(Обст)
 v=Гл1{ Выглядеть_ПРИЛ ВРЕМЯ:НАСТОЯЩЕЕ }:export { ЛИЦО ЧИСЛО РОД ВРЕМЯ node:root_node }
 prop=ГруппаСравнПрил
} : links
{
 v.{
    ~<ATTRIBUTE>adv
    <ATTRIBUTE>prop
   }
}
: ngrams { 1 } // часто компаратив прилагательного и наречия совпадает, повысим достоверность прилагательного,
               // так как можно сказать "ночи становились более длинными"


// -----------------
// ПРОШЕДШЕЕ ВРЕМЯ
// -----------------

//patterns ГлПрош export { node:root_node РОД ЧИСЛО ПЕРЕХОДНОСТЬ ПАДЕЖ }

/*
// кот спал
pattern Сказуемое0 export { (ЛИЦО) ЧИСЛО РОД ВРЕМЯ node:root_node }
{
 v=ГлПрош:export{ РОД ЧИСЛО ВРЕМЯ:ПРОШЕДШЕЕ node:root_node }
 p=@optional(ДеепрИнфОборот)
} : links { v.~<ADV_PARTICIPLE>p }


// кот, свернувшись клубком, спал
pattern Сказуемое0 export { (ЛИЦО) ЧИСЛО РОД ВРЕМЯ node:root_node }
{
 p=ДеепрИнфОборотПеред
 v=ГлПрош:export{ РОД ЧИСЛО ВРЕМЯ:ПРОШЕДШЕЕ node:root_node }
} : links { v.<ADV_PARTICIPLE>p }
*/


/*
// кот это любил
pattern Сказуемое0 export { (ЛИЦО) ЧИСЛО РОД ВРЕМЯ node:root_node }
{
 obj=местоим_сущ:*{ ПАДЕЖ:ВИН }
 v=ГлПрош0{ ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ ПАДЕЖ:ВИН }:export { ЛИЦО ЧИСЛО РОД ВРЕМЯ:ПРОШЕДШЕЕ node:root_node }
} : links { v.<OBJECT>obj }

// Я кое-чему научился
pattern Сказуемое0 export { (ЛИЦО) ЧИСЛО РОД ВРЕМЯ node:root_node }
{
 obj=местоим_сущ:*{ ПАДЕЖ:ДАТ }
 v=ГлПрош0{ ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ ПАДЕЖ:ДАТ }:export { ЛИЦО ЧИСЛО РОД ВРЕМЯ:ПРОШЕДШЕЕ node:root_node }
} : links { v.<OBJECT>obj }


// Компаратив как часть глагольного сказуемого в прошедшем времени
// день стал короче
pattern Сказуемое0 export { (ЛИЦО) ЧИСЛО РОД ВРЕМЯ node:root_node }
{
 adv1=@optional(Обст)
 v=Гл1{ Выглядеть_ПРИЛ ВРЕМЯ:ПРОШЕДШЕЕ }:export { РОД ЧИСЛО ВРЕМЯ node:root_node }
 prop=ГруппаСравнПрил
} : links
{
 v.{
    ~<ATTRIBUTE>adv1
    <ATTRIBUTE>prop
   }
}
*/


// ---------------------------
// АНАЛИТИЧЕСКОЕ БУДУЩЕЕ ВРЕМЯ
// ---------------------------
/*
// кот будет спать
pattern Сказуемое0 export { ЛИЦО ЧИСЛО (РОД) ВРЕМЯ node:root_node }
{
 v=ГлБуд:export{ ЛИЦО ЧИСЛО ВРЕМЯ:БУДУЩЕЕ node:root_node }
 p=@optional(ДеепрИнфОборот)
} : links { v.~<ADV_PARTICIPLE>p }

// кот, полакав молока, уснет
pattern Сказуемое0 export { ЛИЦО ЧИСЛО (РОД) ВРЕМЯ node:root_node }
{
 p=ДеепрИнфОборотПеред
 v=ГлБуд:export{ ЛИЦО ЧИСЛО ВРЕМЯ:БУДУЩЕЕ node:root_node }
} : links { v.<ADV_PARTICIPLE>p }
*/

// Компаратив как часть сказуемого в совершенном будущем времени:
// день станет короче
pattern Сказуемое0 export { ЛИЦО ЧИСЛО (РОД) ВРЕМЯ node:root_node }
{
 adv=@optional(Обст)
 v=Гл1{ Выглядеть_ПРИЛ ВРЕМЯ:БУДУЩЕЕ }:export { ЛИЦО ЧИСЛО ВРЕМЯ node:root_node }
 prop=ГруппаСравнПрил
} : links
{
 v.{
    ~<ATTRIBUTE>adv
    <ATTRIBUTE>prop
   }
}


// Компаратив как часть глагольного сказуемого в аналитическом будущем времени
// день будет становиться короче
pattern Сказуемое0 export { ЛИЦО ЧИСЛО (РОД) ВРЕМЯ node:root_node }
{
 adv=@optional(Обст)
 v=глагол:быть{ ВРЕМЯ:БУДУЩЕЕ }:export { ЛИЦО ЧИСЛО ВРЕМЯ node:root_node }
 inf=инфинитив:*{ Выглядеть_ПРИЛ вид:несоверш }
 prop=ГруппаСравнПрил
} : links
{
 v.{
    ~<ATTRIBUTE>adv
    <INFINITIVE>inf.<ATTRIBUTE>prop
   }
}
: ngrams { 1 } // чтобы повысить достоверность компаратива прилагательного над вариантом с наречием,
               // ибо есть синонимичный вариант с аналитическим компаративом: "день будет становиться более коротким"



// -------------------------------------------------------------

/*
// Нулевая связка и прилагательное
// компания должна заплатить за потребленное топливо
pattern Сказуемое0
{
 a=прилагательное:*{ краткий модальный }:export { РОД ЧИСЛО ЛИЦО:3 ВРЕМЯ:НАСТОЯЩЕЕ node:root_node }
 inf=Инф2
} : links { a.<INFINITIVE>inf }
: ngrams
{
 ВалентностьПрил(a)
}

// вернуться должен до заката
pattern Сказуемое0
{
 inf=Инф2
 a=прилагательное:*{ краткий модальный }:export { РОД ЧИСЛО ЛИЦО:3 ВРЕМЯ:НАСТОЯЩЕЕ node:root_node }
 pn=ПредлогИСущ{ гл_предл(inf,_.prepos,_.n2) }
}
: links { a.<INFINITIVE>inf.<PREPOS_ADJUNCT>pn }
: ngrams
{
 ВалентностьПрил(a)
 ВалентностьГлагола(inf)
}



// всегда рад тебя видеть
pattern Сказуемое0
{
 adv=Обст
 a=прилагательное:*{ краткий модальный }:export { РОД ЧИСЛО ЛИЦО:3 ВРЕМЯ:НАСТОЯЩЕЕ node:root_node }
 inf=Инф2
} : links
{
 a.{
    <ATTRIBUTE>adv
    <INFINITIVE>inf
   }
}
: ngrams
{
 -1
 ВалентностьПрил(a)
}


// компания платить обязана
pattern Сказуемое0
{
 inf=Инф2
 a=прилагательное:*{ краткий модальный }:export { РОД ЧИСЛО ЛИЦО:3 ВРЕМЯ:НАСТОЯЩЕЕ node:root_node }
} : links { a.<INFINITIVE>inf }
: ngrams
{
 ВалентностьПрил(a)
}


// Два прямых дополнения, одно слева от аналитической конструкции:
// вторую пару должен протянуть девушке
pattern Сказуемое0
{
 obj1=ГлДополнение{ ПАДЕЖ:ВИН }
 a=прилагательное:*{ краткий модальный }:export { РОД ЧИСЛО ЛИЦО:3 ВРЕМЯ:НАСТОЯЩЕЕ node:root_node }
 inf=инфинитив:*{ ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ ПАДЕЖ:ВИН ПАДЕЖ:ДАТ }
 obj2=ГлДополнение{ ПАДЕЖ:ДАТ }
} : links
{
 a.<INFINITIVE>inf.{
                    <OBJECT>obj1
                    <OBJECT>obj2
                   }
}
: ngrams
{
 ВалентностьПрил(inf)
 ВалентностьПрил(a)
}
*/

// ---------------------------------------------------------------


// ++++++++++++++++++++++++++



patterns СказуемоеВосх { bottomup  } export { node:root_node РОД ЛИЦО ЧИСЛО ВРЕМЯ }

pattern СказуемоеВосх
{
 Сказуемое0 : export { node:root_node РОД ЛИЦО ЧИСЛО ВРЕМЯ }
} : ngrams { -2 }


// Здесь человек либо сходил с ума, либо переставал чему-либо удивляться.
pattern СказуемоеВосх
{
 conj1=ЛогичСоюз2
 v=Сказуемое0:export{ ЛИЦО ЧИСЛО РОД ВРЕМЯ node:root_node }
 comma=','
 conj2=ЛогичСоюз2
 v2=Сказуемое0{=V:ЛИЦО =V:ЧИСЛО =V:РОД}
} : links
{
 v.{
    <PREFIX_CONJUNCTION>conj1
    <RIGHT_LOGIC_ITEM>comma.<NEXT_COLLOCATION_ITEM>conj2.<NEXT_COLLOCATION_ITEM>v2
   }
}
: ngrams { 2 }


// вы едите пюре или суп, потом пьете чай
//                      ^^^^^^^^^^^^^^^^^
pattern СказуемоеВосх
{
 v=СказуемоеВосх:export{ ЛИЦО ЧИСЛО РОД ВРЕМЯ node:root_node }
 comma=','
 v2=Сказуемое0{=V:ЛИЦО =V:ЧИСЛО =V:РОД}
}
: links { v.<RIGHT_LOGIC_ITEM>comma.<NEXT_COLLOCATION_ITEM>v2 }
: ngrams { 2 }


// Человек взял да убежал
//         ^^^^^^^^^^^^^^
pattern СказуемоеВосх
{
 v=СказуемоеВосх:export{ ЛИЦО ЧИСЛО РОД ВРЕМЯ node:root_node }
 conj=ЛогичСоюз
 v2=Сказуемое0{=V:ЛИЦО =V:ЧИСЛО =V:РОД}
}
: links { v.<RIGHT_LOGIC_ITEM>conj.<NEXT_COLLOCATION_ITEM>v2 }
: ngrams { 2 }



// Он поднимался вверх на несколько дюймов, прочно упирался ногами в стену, а затем распрямлял колени.
pattern СказуемоеВосх
{
 v=СказуемоеВосх:export{ ЛИЦО ЧИСЛО РОД ВРЕМЯ node:root_node }
 comma=','
 conj=ПротивитСоюз
 v2=Сказуемое0{=V:ЛИЦО =V:ЧИСЛО =V:РОД}
} : links
{
 v.<RIGHT_LOGIC_ITEM>comma.
    <NEXT_COLLOCATION_ITEM>conj.
     <NEXT_COLLOCATION_ITEM>v2
}
: ngrams { 2 }


// я не только прошу , но и умоляю
pattern СказуемоеВосх
{
 v=СказуемоеВосх:export{ ЛИЦО ЧИСЛО РОД ВРЕМЯ node:root_node }
 comma=','
 conj1=союз:но{}
 conj2=союз:и{}
 v2=Сказуемое0{=V:ЛИЦО =V:ЧИСЛО =V:РОД}
} : links
{
 v.<RIGHT_LOGIC_ITEM>comma.
    <NEXT_COLLOCATION_ITEM>conj1.
     <NEXT_COLLOCATION_ITEM>conj2.
      <NEXT_COLLOCATION_ITEM>v2
}
: ngrams { 2 }


// вы едите пюре или суп, потом пьете чай, и наконец пойдете спать
pattern СказуемоеВосх
{
 v=СказуемоеВосх:export{ ЛИЦО ЧИСЛО РОД ВРЕМЯ node:root_node }
 comma=','
 conj=союз:и{}
 v2=Сказуемое0{=V:ЛИЦО =V:ЧИСЛО =V:РОД}
} : links
{
 v.<RIGHT_LOGIC_ITEM>comma.
    <NEXT_COLLOCATION_ITEM>conj.
     <NEXT_COLLOCATION_ITEM>v2
}
: ngrams { 2 }


// После второй мировой войны он поступил в университет, но через год бросил учебу и ввязался в дела властителей.
pattern СказуемоеВосх
{
 v=СказуемоеВосх:export{ ЛИЦО ЧИСЛО РОД ВРЕМЯ node:root_node }
 conj=союз:и{}
 v2=Сказуемое0{=V:ЛИЦО =V:ЧИСЛО =V:РОД}
} : links
{
 v.<RIGHT_LOGIC_ITEM>conj.
   <NEXT_COLLOCATION_ITEM>v2
}
: ngrams { 2 }


wordentry_set СочинПротивСоюзСказ=союз:{ и, а, но, что, ибо, поскольку, однако,
 'потому что', 'так как', то }

// я выпил несколько чашек крепкого кофе, и теперь не могу уснуть
pattern СказуемоеВосх
{
 v=СказуемоеВосх:export{ ЛИЦО ЧИСЛО РОД ВРЕМЯ node:root_node }
 comma=','
 conj=СочинПротивСоюзСказ
 v2=Сказуемое0{=V:ЛИЦО =V:ЧИСЛО =V:РОД}
} : links
{
 v.<RIGHT_LOGIC_ITEM>comma.
    <NEXT_COLLOCATION_ITEM>conj.
     <NEXT_COLLOCATION_ITEM>v2
}
: ngrams { 2 }



// она либо утонула, либо нашла тайник для контрабанды, либо попросту испарилась в воздухе.
pattern СказуемоеВосх
{
 v=СказуемоеВосх:export{ ЛИЦО ЧИСЛО РОД ВРЕМЯ node:root_node }
 comma=','
 conj=ЛогичСоюз2
 v2=Сказуемое0{=V:ЛИЦО =V:ЧИСЛО =V:РОД}
} : links
{
 v.<RIGHT_LOGIC_ITEM>comma.
    <NEXT_COLLOCATION_ITEM>conj.
     <NEXT_COLLOCATION_ITEM>v2
}
: ngrams { 1 }



// -------------

pattern Сказуемое
{
 СказуемоеВосх : export { node:root_node РОД ЛИЦО ЧИСЛО ВРЕМЯ }
}

// ++++++++++++++++++++++++++


// Сказуемое со словом СЛОВНО
// Цветущий луг словно ковёр
pattern Сказуемое export { (ЛИЦО) (ЧИСЛО) (РОД) (ВРЕМЯ) node:root_node }
{
 adv=наречие:словно{} : export { node:root_node }
 obj=ГлДополнение{ПАДЕЖ:ИМ}
} : links { adv.<OBJECT>obj }


// -----------------------------------------------------------------------


// ------------------------
// Подлежащее+Сказуемое
// ------------------------


wordform_set ИнфСвязка = {
'значит'{class:глагол},
'значило'{},
'означает'{},
'означало'{}
}

// держать во рту значит помнить
// уступить значило проиграть
// избежать ее означало бы потерять нашу свободу.
pattern ГлПредикат
{
 inf1=Инф2
 v=ИнфСвязка : export { node:root_node }
 p=@optional(частица:бы{})
 inf2=Инф2
}
: links
{
 v.{
    ~<POSTFIX_PARTICLE>p
    <THEMA>inf1
    <RHEMA>inf2
   }
}


/*
// нам эта группа будет подчиняться
pattern ГлПредикат
{
 Obj=ГлДополнение{ПАДЕЖ:ДАТ}
 N=Подлежащее
 aux=ГлБытьБудущ : export { node:root_node }
 p=@optional(частица:ли{})
 adv1=@optional(ГруппаНареч2)
 inf=ИНФИНИТИВ:*{ ВИД:НЕСОВЕРШ ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ ПАДЕЖ:ДАТ }
} : links
{
 aux.{
      <SUBJECT>n
      ~<POSTFIX_PARTICLE>p
      <INFINITIVE>inf.{
                       ~<ATTRIBUTE>adv1
                       <OBJECT>obj
                      }
     }
}
: ngrams
{
 v_obj_score( inf, obj )
 adv_verb_score( adv1, inf )
 ВалентностьГлагола(aux)
 ВалентностьГлагола(inf)
 ВалентностьПредиката(aux)
}
*/

// +++++++++++++++++++++++++




patterns ГлПредикатНисх export { node:root_node РОД ЛИЦО ЧИСЛО ПАДЕЖВАЛ }


pattern ГлПредикатНисх
{
 Сказуемое : export { node:root_node РОД ЛИЦО ЧИСЛО ПАДЕЖВАЛ:ИМ }
} : ngrams { -10 }

// Дверь скрипит и трещит
pattern ГлПредикатНисх export { node:root_node РОД ЛИЦО ЧИСЛО (ПАДЕЖВАЛ) }
{
 N=Подлежащее
 V=ГлПредикатНисх{ ПАДЕЖВАЛ:ИМ =N:РОД =N:ЛИЦО =N:ЧИСЛО } : export { РОД ЛИЦО ЧИСЛО node:root_node }
}
: links { v.<SUBJECT>n }
: ngrams
{
 10
 sbj_v_score( n, v )
}


// мгновение спустя дверь снова скрипнула и закрылась.
pattern ГлПредикатНисх
{
 adv=Обст
 V=ГлПредикатНисх : export { РОД ЛИЦО ЧИСЛО ПАДЕЖВАЛ node:root_node }
}
: links { v.<ATTRIBUTE>adv }
: ngrams { adv_verb_score( adv, v ) }


// За углом кто-то закричал и затопал ногами
pattern ГлПредикатНисх
{
 pn=ПредлогИСущ
 V=ГлПредикатНисх{ гл_предл(_,pn.prepos,pn.n2) } : export { РОД ЛИЦО ЧИСЛО ПАДЕЖВАЛ node:root_node }
}
: links { v.<PREPOS_ADJUNCT>pn }
: ngrams
{
 prepos_score( v, pn.prepos )
 ngram3( v, pn.prepos, pn.n2 )
}

// вернее сказать, мы пропустили нужный поворот, заблудились в лесу и можем погибнуть
pattern ГлПредикатНисх
{
 intro=ВводнАктант
 V=ГлПредикатНисх : export { РОД ЛИЦО ЧИСЛО ПАДЕЖВАЛ node:root_node }
}
: links { v.<BEG_INTRO>intro }


// Уставшие и голодные, они уселись за стол и начали есть
pattern ГлПредикатНисх
{
 attr=ОбособленныйАтрибут
 V=ГлПредикатНисх : export { РОД ЛИЦО ЧИСЛО ПАДЕЖВАЛ node:root_node }
} : links { v.<SEPARATE_ATTR>attr }



// -------------

pattern ГлПредикат
{
 v=ГлПредикатНисх{ ~ПАДЕЖВАЛ:ИМ } : export { node:root_node }
} : ngrams { ВалентностьПредиката(v) }

// --------------

