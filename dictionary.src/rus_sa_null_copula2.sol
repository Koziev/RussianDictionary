// Восходяще-нисходящий разбор конструкций с нулевой связкой
// с именным сказуемым, согласующимся по числу с темой-подлежащим.


// -------------------------------------------------------

patterns ИменноеСказуемоеВосх { bottomup } export { node:root_node ЧИСЛО }

// Ты настоящий герой
//    ^^^^^^^^^^^^^^^
pattern ИменноеСказуемоеВосх
{
 ГруппаСущ4{ ПАДЕЖ:ИМ } : export { ЧИСЛО node:root_node }
}

// Она умная и красивая
//     ^^^^^^^^^^^^^^^^
pattern ИменноеСказуемоеВосх
{
 ГруппаПрил2{ ПАДЕЖ:ИМ } : export { ЧИСЛО node:root_node }
} : ngrams { -2 }


pattern ИменноеСказуемоеВосх
{
 ГруппаМест{ ПАДЕЖ:ИМ } : export { ЧИСЛО node:root_node }
} : ngrams { -4 }


// ------------------------------------------

// ты кто?
//    ^^^

patterns КтоСказуемое export { node:root_node }
pattern КтоСказуемое
{
 n=местоим_сущ:*{ РОД:МУЖ ПАДЕЖ:ИМ } : export { node:root_node }
}

// Ты-то кто же?
//       ^^^^^^
pattern КтоСказуемое
{
 n=местоим_сущ:*{ РОД:МУЖ ПАДЕЖ:ИМ } : export { node:root_node }
 p=ЧастицаЖе
}
: links { n.<POSTFIX_PARTICLE>p }
: ngrams { 1 }


pattern ИменноеСказуемоеВосх export { (ЧИСЛО) node:root_node }
{
 КтоСказуемое : export { node:root_node }
}

// ------------------------------------------

// без нее ты ничто
//            ^^^^^

patterns ЧтоСказуемое export { node:root_node }

// Это что?
//     ^^^
pattern ЧтоСказуемое
{
 n=местоим_сущ:*{ род:ср падеж:им } : export { node:root_node }
}

pattern ЧтоСказуемое
{
 n=местоим_сущ:*{ род:ср падеж:им } : export { node:root_node }
 p=ЧастицаЖе
}
: links { n.<POSTFIX_PARTICLE>p }
: ngrams { 1 }

pattern ИменноеСказуемоеВосх
{
 ЧтоСказуемое : export { ЧИСЛО:ЕД node:root_node }
}


// -----------------------------------

// Кто это?
pattern ИменноеСказуемоеВосх
{
 местоим_сущ:это{ ПАДЕЖ:ИМ } : export { ЧИСЛО:ЕД node:root_node }
}


// ------------------------------------------



/*
// Он не господин в своем доме.
//    ^^^^^^^^^^^
pattern ИменноеСказуемоеВосх
{
 p=частица:не{}
 n=ГлДополнение{ ПАДЕЖ:ИМ } : export { node:root_node }
} : links { n.<NEGATION_PARTICLE>p }
*/


pattern ИменноеСказуемоеВосх
{
 v=ИменноеСказуемоеВосх : export { ЧИСЛО node:root_node }
 obj=ГлДополнение{ ~ПАДЕЖ:ИМ ~ПАДЕЖ:ПРЕДЛ }
}
: links { v.<OBJECT>obj }
: ngrams { -8 }


// ты предатель теперь
pattern ИменноеСказуемоеВосх
{
 v=ИменноеСказуемоеВосх : export { ЧИСЛО node:root_node }
 adv=Обст
}
: links { v.<ATTRIBUTE>adv }
//: ngrams { -1 }


// Она умница, конечно.
pattern ИменноеСказуемоеВосх
{
 v=ИменноеСказуемоеВосх : export { ЧИСЛО node:root_node }
 adv=ВводнАктант
} : links { v.<BEG_INTRO>adv }


pattern ИменноеСказуемоеВосх
{
 v=ИменноеСказуемоеВосх : export { ЧИСЛО node:root_node }
 d=Детализатор
} : links { v.<DETAILS>d }


pattern ИменноеСказуемоеВосх
{
 v=ИменноеСказуемоеВосх : export { ЧИСЛО node:root_node }
 pn=ПредлогИСущ
}
: links { v.<PREPOS_ADJUNCT>pn }
: ngrams { -5 }

// кто же она такая?
//            ^^^^^
pattern ИменноеСказуемоеВосх
{
 v=ИменноеСказуемоеВосх : export { ЧИСЛО node:root_node }
 attr=ОбособленныйАтрибут
}
: links { v.<SEPARATE_ATTR>attr }
: ngrams { -5 }

// Обособленный атрибут в иминительном падеже, согласующийся
// со сказуемым по числу:
//
// Кто ты такой?
//        ^^^^^
pattern ИменноеСказуемоеВосх
{
 v=ИменноеСказуемоеВосх : export { ЧИСЛО node:root_node }
 attr=ГруппаПрил2{ ПАДЕЖ:ИМ =v:ЧИСЛО }
}
: links { v.<SEPARATE_ATTR>attr }
: ngrams { -2 }

// так кто вы такой?
//            ^^^^^
pattern ИменноеСказуемоеВосх
{
 v=ИменноеСказуемоеВосх : export { ЧИСЛО node:root_node }
 attr=ГруппаПрил2{ ПАДЕЖ:ИМ }
}
: links { v.<SEPARATE_ATTR>attr }
: ngrams { -3 }


// --------------------------------------------------------

patterns ИменноеСказуемоеНисх export { ЧИСЛО THEMA_VALENCY node:root_node }

pattern ИменноеСказуемоеНисх
{
 ИменноеСказуемоеВосх : export { ЧИСЛО THEMA_VALENCY:1 node:root_node }
}

// Ты теперь начальник
pattern ИменноеСказуемоеНисх
{
 adv=Обст
 v=ИменноеСказуемоеНисх : export { ЧИСЛО THEMA_VALENCY node:root_node }
}
: links { v.<ATTRIBUTE>adv }
: ngrams { -1 }


// Конечно, ты начальник.
pattern ИменноеСказуемоеНисх
{
 intro=ВводнАктант
 v=ИменноеСказуемоеНисх : export { ЧИСЛО THEMA_VALENCY node:root_node }
} 
: links { v.<BEG_INTRO>intro }


pattern ИменноеСказуемоеНисх
{
 intro=Детализатор
 v=ИменноеСказуемоеНисх : export { ЧИСЛО THEMA_VALENCY node:root_node }
} 
: links { v.<DETAILS>intro }


// На работе ты босс.
pattern ИменноеСказуемоеНисх
{
 pn=ПредлогИСущ
 v=ИменноеСказуемоеНисх : export { ЧИСЛО THEMA_VALENCY node:root_node }
} 
: links { v.<PREPOS_ADJUNCT>pn }
: ngrams { -5 }



pattern ИменноеСказуемоеНисх
{
 obj=ГлДополнение{ ~ПАДЕЖ:ИМ ~ПАДЕЖ:ПРЕДЛ }
 v=ИменноеСказуемоеНисх : export { ЧИСЛО THEMA_VALENCY node:root_node }
}
: links { v.<OBJECT>obj }
: ngrams { -8 }


// Обособленное определение:
// хороший ты человек
// ^^^^^^^
pattern ИменноеСказуемоеНисх
{
 attr=ГруппаПрил2{ ПАДЕЖ:ИМ }
 v=ИменноеСказуемоеНисх{ =attr:ЧИСЛО } : export { ЧИСЛО THEMA_VALENCY node:root_node }
}
: links { v.<SEPARATE_ATTR>attr }
: ngrams { -2 }

// Хороший Вы человек.
// ^^^^^^^
pattern ИменноеСказуемоеНисх
{
 attr=ГруппаПрил2{ ПАДЕЖ:ИМ }
 v=ИменноеСказуемоеНисх : export { ЧИСЛО THEMA_VALENCY node:root_node }
}
: links { v.<SEPARATE_ATTR>attr }
: ngrams { -3 }



// Прикрепляем подлежащее
pattern ИменноеСказуемоеНисх
{
 sbj=Подлежащее
 v=ИменноеСказуемоеНисх{ THEMA_VALENCY:1 =sbj:ЧИСЛО } : export { ЧИСЛО THEMA_VALENCY:0 node:root_node }
}
: links { v.<SUBJECT>sbj }


// --------------------------------------------------------------------
// Местоимение ВЫ согласуется с именным сказуемым в единственном числе:
//
// вы гость
pattern ИменноеСказуемоеНисх
{
 sbj=ГруппаМест{ ЛИЦО:2 ЧИСЛО:МН ПАДЕЖ:ИМ }
 v=ИменноеСказуемоеНисх{ THEMA_VALENCY:1 ЧИСЛО:ЕД } : export { ЧИСЛО THEMA_VALENCY:0 node:root_node }
}
: links { v.<SUBJECT>sbj }


// --------------------------------------------------

// Местоимение ЭТО в роли подлежащего, без согласования по числу:

patterns Это_Тема export { node:root_node }

// это два разных воспоминания
// ^^^
pattern Это_Тема
{
 n=местоим_сущ:это{ ПАДЕЖ:ИМ } : export { node:root_node }
}


// это же дракон!
// ^^^^^^
pattern Это_Тема
{
 n=местоим_сущ:это{ ПАДЕЖ:ИМ } : export { node:root_node }
 p=ЧастицаЖе
} : links { n.<POSTFIX_PARTICLE>p }

// Это-то я понял
// ^^^^^^
pattern Это_Тема
{
 n=местоим_сущ:это{ ПАДЕЖ:ИМ } : export { node:root_node }
 t='-'
 p=частица:то{}
} : links { n.<POSTFIX_PARTICLE>t.<NEXT_COLLOCATION_ITEM>p }


// это мои слова
// ^^^
pattern ИменноеСказуемоеНисх
{
 sbj=Это_Тема
 v=ИменноеСказуемоеНисх{ THEMA_VALENCY:1 } : export { ЧИСЛО THEMA_VALENCY:0 node:root_node }
}
: links { v.<SUBJECT>sbj }


// -------------------------------------------------


// -------------------------------------------------

patterns КтоПодлежащее export { node:root_node }
pattern КтоПодлежащее
{
 n=местоим_сущ:кто{ ПАДЕЖ:ИМ } : export { node:root_node }
}

// кто же хозяин этих птиц?
// ^^^^^^
pattern КтоПодлежащее
{
 n=местоим_сущ:кто{ ПАДЕЖ:ИМ } : export { node:root_node }
 p=ЧастицаЖе
} : links { n.<POSTFIX_PARTICLE>p }
: ngrams { 1 }


// Да кто же вы?
pattern ИменноеСказуемоеНисх
{
 sbj=КтоПодлежащее
 v=ИменноеСказуемоеНисх{ THEMA_VALENCY:1 } : export { ЧИСЛО THEMA_VALENCY:0 node:root_node }
}
: links { v.<SUBJECT>sbj }


// ============================================================

// Пусть разберутся, в чем дело.
//                   ^^^^^^^^^^
pattern ПредикатСвязка
{
 t=ИменноеСказуемоеНисх{ THEMA_VALENCY:0 } : export { node:root_node }
}
: ngrams
{
 -10
 ВалентностьНульСвязки(t)
}


// ---------------------------------------


/*
// Отдельно разбираем предложения с шаблоном ЭТО + сущ.:
//
// Это один из самых лучших дней моей жизни
pattern ПредикатСвязка
{
 t=Это_Тема
 r=ТемаРема : export { node:root_node }
}
: links { r.<SUBJECT>t }
: ngrams
{
 ВалентностьНульСвязки(r)
}
*/

/*
// это мой чемодан
// это для тебя самое подходящее место
// сегодня это для нас самое безопасное место
// это же нормальные люди!
pattern ПредикатСвязка
{
 adv=@optional(Обст)
 sbj=ЭТО_Местоим : export { node:root_node }
 pn=@optional(ПредлогИСущ)
 r=ГруппаСущ4{ падеж:им }
} : links
{
 sbj.{
      ~<ATTRIBUTE>adv
      <RHEMA>r
      ~<PREPOS_ADJUNCT>pn
     }
}
: ngrams { 10 }
*/


// ---------------------------------------

/*
patterns МестПодлежПредикатСвязка export { node:root_node ЧИСЛО }

// Мы с вами тёзки.
// ^^^^^^^^^
pattern МестПодлежПредикатСвязка
{
 ГруппаМест{ падеж:им } : export { node:root_node ЧИСЛО }
}


// Теперь он знает, что и мы не слабаки.
pattern МестПодлежПредикатСвязка
{
 p=частица:и{}
 n=местоимение:я{ падеж:им } : export { node:root_node ЧИСЛО }
} : links { n.<PREFIX_PARTICLE>p }
: ngrams { -1 }


// ты же наш король
// ^^^^^
pattern МестПодлежПредикатСвязка
{
 n=местоимение:я{ падеж:им } : export { node:root_node ЧИСЛО }
 p=ЧастицаЖе
} : links { n.<POSTFIX_PARTICLE>p }

// ВЫ может быть подлежащим единственного числа:
// Вы истинный сын человеческий?
// ^^
// Вы же сын такого известного  папаши!
// ^^^^^
pattern МестПодлежПредикатСвязка
{
 ГруппаМест{ лицо:2 число:мн падеж:им } : export { node:root_node ЧИСЛО:ед }
}


// нулевая связка настоящего времени:
// он настоящий друг и товарищ
pattern ПредикатСвязка
{
 p=МестПодлежПредикатСвязка : export { node:root_node }
 r=ГруппаСущ4{ падеж:им =P:ЧИСЛО }
} : links { p.<RHEMA>r }
  : ngrams { -1 } // штраф, так как может происходить коллизия ВЫ ЕЛИ
*/



// -------------------------------------------------

/*
// Одушевленное подлежащее для вопросительной конструкции:
// Кто она?
patterns КтоТема export { node:root_node }
pattern КтоТема
{
 n=местоим_сущ:кто{} : export { node:root_node }
}

// кто же хозяин этих птиц?
// ^^^^^^
pattern КтоТема
{
 n=местоим_сущ:кто{} : export { node:root_node }
 p=ЧастицаЖе
} : links { n.<POSTFIX_PARTICLE>p }
: ngrams { 1 }



// Кто ты?
// кто их враги?
pattern ПредикатСвязка
{
 p=КтоТема : export { node:root_node }
 r=Подлежащее
} : links { p.<RHEMA>r }
*/

// -------------------------------------------------------
/*
patterns ЧтоТема export { node:root_node }
pattern ЧтоТема
{
 n=местоим_сущ:что{ падеж:им } : export { node:root_node }
}

pattern ЧтоТема
{
 n=местоим_сущ:что{ падеж:им } : export { node:root_node }
 p=ЧастицаЖе
} : links { n.<POSTFIX_PARTICLE>p }
: ngrams { 1 }


// Что такое учеба?
pattern ПредикатСвязка
{
 p=ЧтоТема : export { node:root_node }
 a=прилагательное:такой{ падеж:им число:ед род:ср }
 r=ГруппаСущ4{ ПАДЕЖ:ИМ }
} : links
{
 p.{
    <ATTRIBUTE>a
    <RHEMA>r
   }
}
*/

// -----------------------------------------

/*

// Он  же  на  работе.
pattern ПредикатСвязка
{
 p=МестПодлежПредикатСвязка : export { node:root_node }
 r=ОбстМеста
} : links { p.<RHEMA>r }
  : ngrams { -1 }


wordentry_set НаречияВремени=наречие:{
 сегодня,
 опять,
 снова,
 сейчас,
 теперь,
 завтра
}

// Сегодня хорошая погода
pattern ПредикатСвязка
{
 thema=НаречияВремени{ степень:атриб } : export { node:root_node }
 r=ГруппаСущ4{ падеж:им }
} : links { thema.<RHEMA>r }
  : ngrams { -1 } // штраф, так как может происходить коллизия ВЫ ЕЛИ

// вот опять этот демон!
pattern ПредикатСвязка
{
 p=Частица:вот{}
 thema=НаречияВремени{ степень:атриб } : export { node:root_node }
 r=ГруппаСущ4{ падеж:им }
} : links
{
 thema.{
        <RHEMA>r
        <PREFIX_PARTICLE>p
       }
}
: ngrams { -1 }
*/


// ---------------------------------

/*

// *****************************
// Нулевая связка и наречие
// *****************************

patterns НаречиеКакСвязка export { node:root_node }
pattern НаречиеКакСвязка
{
 наречие:*{степень:атриб} : export { node:root_node }
}

pattern НаречиеКакСвязка
{
 adv1=наречие:*{степень:атриб} : export { node:root_node }
 adv2=наречие:совсем{}
} : links { adv1.<ATTRIBUTE>adv2 }

// он уже старик
pattern ПредикатСвязка
{
 sbj=МестПодлежПредикатСвязка
 v=НаречиеКакСвязка : export { node:root_node }
 r=СущСПредложДоп{ падеж:им =Sbj:ЧИСЛО ОДУШ:ОДУШ }
} : links
{
 v.{
    <SUBJECT>sbj
    <RHEMA>r
   }
}
: ngrams { -2 }


// Антонио уже старик
pattern ПредикатСвязка
{
 @mark(существительное:*{ падеж:им },Sbj)
 v=НаречиеКакСвязка : export { node:root_node }
 r=СущСПредложДоп{ падеж:им =Sbj:ЧИСЛО ОДУШ:ОДУШ }
} : links
{
 v.{
    <SUBJECT>sbj
    <RHEMA>r
   }
}
: ngrams { -2 }


// он уже опытный
pattern ПредикатСвязка
{
 sbj=МестПодлежПредикатСвязка
 v=НаречиеКакСвязка : export { node:root_node }
 r=ГруппаПрил2{ падеж:им =Sbj:ЧИСЛО =Sbj:РОД }
} : links
{
 v.{
    <SUBJECT>sbj
    <RHEMA>r
   }
}
: ngrams { -2 }

// Антонио уже опытный
pattern ПредикатСвязка
{
 @mark(существительное:*{ падеж:им },Sbj)
 v=НаречиеКакСвязка : export { node:root_node }
 r=ГруппаПрил2{ падеж:им =Sbj:ЧИСЛО =Sbj:РОД }
} : links
{
 v.{
    <SUBJECT>sbj
    <RHEMA>r
   }
}
: ngrams { -2 }

// теперь меч навеки мой!
pattern ПредикатСвязка
{
 adv=наречие:*{ степень:атриб }
 @mark(существительное:*{ падеж:им },Sbj)
 v=НаречиеКакСвязка : export { node:root_node }
 r=ГруппаПрил2{ падеж:им =Sbj:ЧИСЛО =Sbj:РОД }
} : links
{
 v.{
    <SUBJECT>sbj
    <RHEMA>r
    <ATTRIBUTE>adv
   }
}
: ngrams { -2 }

*/


/*


// Нулевая связка и полное прилагательное в роли ремы:
// ты холодный!
pattern ПредикатСвязка
{
 N=Подлежащее
 r=ГруппаПрил2{ ПАДЕЖ:ИМ =N:РОД =N:ЧИСЛО } : export { node:root_node }
} : links
{
 r.{
    <SUBJECT>N
   }
}
: ngrams
{
 -1 // обычно в роли ремы для паттерна с нулевой связкой используется краткая форма прилагательного
}


*/
