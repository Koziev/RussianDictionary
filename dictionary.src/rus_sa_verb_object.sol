patterns ГлОбъект export { ПАДЕЖ node:root_node }

word_set ЗапретПрямойОбъект=
{
 "него", "нее", "ним", "ней", "нему", "нем", "них", "ними"
}

// (-): Повсюду вокруг него кричали птицы
//                     ~~~~
pattern ГлОбъект
{
 ГлДополнение{ ~ЗапретПрямойОбъект } : export { ПАДЕЖ node:root_node }
}

// -----------------------------------------------------------------------


patterns ИнфКакОбъектВосх { bottomup } export { node:root_node ПЕРЕХОДНОСТЬ ПАДЕЖ ВИД МОДАЛЬНЫЙ }

patterns Инф0 export { ПЕРЕХОДНОСТЬ ПАДЕЖ ВИД МОДАЛЬНЫЙ node:root_node } 

pattern ИнфКакОбъектВосх
{
 Инф0 : export { node:root_node ПЕРЕХОДНОСТЬ ПАДЕЖ ВИД МОДАЛЬНЫЙ }
}


pattern ИнфКакОбъектВосх
{
 v=ИнфКакОбъектВосх{ ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ } : export { node:root_node ВИД МОДАЛЬНЫЙ }
 obj=ГлОбъект{ =v:ПАДЕЖ } : export {
                                    @except(v:ПАДЕЖ,ПАДЕЖ)
                                    @if_exported(ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ,ПАДЕЖ)
                                   }
}
: links { v.<OBJECT>obj }
: ngrams { v_obj_score(v,obj) }

// дательное дополнение+предложное премыкание НА/В+предл:
// сесть на спину второму
pattern ИнфКакОбъектВосх
{
 v=ИнфКакОбъектВосх{ ~ПАДЕЖ:ДАТ } : export { node:root_node ВИД МОДАЛЬНЫЙ ПАДЕЖ ПЕРЕХОДНОСТЬ }
 obj=ДатОбъект
}
: links { v.<OBJECT>obj }
: ngrams { -10 }




pattern ИнфКакОбъектВосх
{
 v=ИнфКакОбъектВосх : export { node:root_node ПЕРЕХОДНОСТЬ ПАДЕЖ ВИД МОДАЛЬНЫЙ }
 adv=Обст
} : links
{
 v.<ATTRIBUTE>adv
}
: ngrams
{
 adv_verb_score( adv, v )
}

// +++++++++++

patterns БессоюзноеПридаточное export{ ПАДЕЖ node:root_node }

// Бессоюзное правое придаточное:
// разобрать, что бормотал лектор
pattern ИнфКакОбъектВосх export{ ПЕРЕХОДНОСТЬ ВИД (МОДАЛЬНЫЙ) (ПАДЕЖ) node:root_node }
{
 v=ИнфКакОбъектВосх{ ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ ПАДЕЖ:ВИН } : export { node:root_node ВИД ПЕРЕХОДНОСТЬ:НЕПЕРЕХОДНЫЙ }
 p=БессоюзноеПридаточное
}
: links { v.<SUBORDINATE_CLAUSE>p }
: ngrams
{
 -1
 ВалентностьБессоюзнПридаточн(v)
}


// я хочу понять, почему кошка сильнее собаки
pattern ИнфКакОбъектВосх
{
 inf=ИнфКакОбъектВосх:export{ПЕРЕХОДНОСТЬ ПАДЕЖ ВИД МОДАЛЬНЫЙ node:root_node }
 comma=','
 conj=СоединДляПридаточного
 p=ПридаточноеВОбороте
 comma2=@coalesce(',')
} : links
{
 inf.<SUBORDINATE_CLAUSE>comma.
      <NEXT_COLLOCATION_ITEM>conj.
       <NEXT_COLLOCATION_ITEM>p.~<PUNCTUATION>comma2
}
: ngrams { 1 }

// +++

pattern ИнфКакОбъектВосх
{
 v=ИнфКакОбъектВосх : export { node:root_node ПЕРЕХОДНОСТЬ ПАДЕЖ ВИД МОДАЛЬНЫЙ }
 pn=ПредлогИСущ{ гл_предл( v, _.prepos, _.n2 ) }
} : links
{
 v.<PREPOS_ADJUNCT>pn
}
: ngrams
{
 prepos_score( v, pn.prepos )
 ngram3( v, pn.prepos, pn.n2 )
}


// --------------------------------------------------------

patterns ИнфКакОбъектНисх export { node:root_node ПЕРЕХОДНОСТЬ ПАДЕЖ ВИД }

pattern ИнфКакОбъектНисх
{
 ИнфКакОбъектВосх : export { node:root_node ПЕРЕХОДНОСТЬ ПАДЕЖ ВИД }
}

patterns ОбстДляДееприч export { node:root_node }


pattern ИнфКакОбъектНисх
{
 adv=ОбстДляДееприч
 v=ИнфКакОбъектНисх : export { node:root_node ПЕРЕХОДНОСТЬ ПАДЕЖ ВИД }
} 
: links
{
 v.<ATTRIBUTE>adv
}
: ngrams
{
 adv_verb_score( adv, v )
}


pattern ИнфКакОбъектНисх
{
 pn=ПредлогИСущ
 v=ИнфКакОбъектНисх { гл_предл(_,pn.prepos,pn.n2) } : export { node:root_node ПЕРЕХОДНОСТЬ ПАДЕЖ ВИД }
} 
: links
{
 v.<PREPOS_ADJUNCT>pn
}
: ngrams
{
 -1
 prepos_score( v, pn.prepos )
 ngram3( v, pn.prepos, pn.n2 )
}


/*
pattern ИнфКакОбъектНисх
{
 obj=ГлОбъект
 v=ИнфКакОбъектНисх { ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ =Obj:ПАДЕЖ }
     : export { 
               node:root_node ВИД
               @except(ПАДЕЖ,obj:ПАДЕЖ)
               @if_exported(ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ,ПАДЕЖ)
              }
} : links { v.<OBJECT>obj }
: ngrams
{
 -1 // обычно дополнения ставятся ПОСЛЕ деепричастия
 v_obj_score( v, obj )
}
*/

/*
// Объект в дательном падеже прикрепляется даже в случаях, когда
// у глагола нет нужной валентности:
//
// на спину дракону сесть
//          ^^^^^^^
// Глазу зацепиться не за что.
// ^^^^^
pattern ИнфКакОбъектНисх
{
 obj=ДатОбъект
 v=ИнфКакОбъектНисх { ~ПАДЕЖ:ДАТ } : export { node:root_node ВИД ПАДЕЖ ПЕРЕХОДНОСТЬ }
}
: links { v.<OBJECT>obj }
: ngrams { -5 }
*/

// --------------------

patterns ИнфКакОбъект2Восх { bottomup } export { node:root_node }

patterns ИнфКакОбъект2Хвост { bottomup } export { node:root_node }
pattern ИнфКакОбъект2Хвост
{
 ИнфКакОбъектНисх : export { node:root_node }
}


pattern ИнфКакОбъект2Восх
{
 ИнфКакОбъектНисх : export { node:root_node }
}

pattern ИнфКакОбъект2Восх
{
 i1=ИнфКакОбъект2Восх : export { node:root_node }
 comma=','
 i2=ИнфКакОбъект2Хвост
} : links { i1.<RIGHT_LOGIC_ITEM>comma.<NEXT_COLLOCATION_ITEM>i2 }


pattern ИнфКакОбъект2Восх
{
 i1=ИнфКакОбъект2Восх : export { node:root_node }
 comma=','
 conj=ЛогичСоюз
 i2=ИнфКакОбъект2Хвост
} : links { i1.<RIGHT_LOGIC_ITEM>comma.<NEXT_COLLOCATION_ITEM>conj.<NEXT_COLLOCATION_ITEM>i2 }


pattern ИнфКакОбъект2Восх
{
 i1=ИнфКакОбъект2Восх : export { node:root_node }
 conj=ЛогичСоюз
 i2=ИнфКакОбъект2Хвост
} : links { i1.<RIGHT_LOGIC_ITEM>conj.<NEXT_COLLOCATION_ITEM>i2 }

pattern ИнфКакОбъект2Восх
{
 i1=ИнфКакОбъект2Восх : export { node:root_node }
 conj=ПротивитСоюз
 i2=ИнфКакОбъект2Хвост
} : links { i1.<RIGHT_LOGIC_ITEM>conj.<NEXT_COLLOCATION_ITEM>i2 }


pattern ИнфКакОбъект2Восх
{
 i1=ИнфКакОбъект2Восх : export { node:root_node }
 comma=','
 conj=ПротивитСоюз
 i2=ИнфКакОбъект2Хвост
} : links { i1.<RIGHT_LOGIC_ITEM>comma.<NEXT_COLLOCATION_ITEM>conj.<NEXT_COLLOCATION_ITEM>i2 }



pattern ИнфКакОбъект2Восх
{
 conj1=СочинительныйСоюз1
 a1=ИнфКакОбъект2Восх : export { node:root_node }
 comma=','
 conj2=СочинительныйСоюз2
 a2=ИнфКакОбъект2Хвост
}
: links
{
 a1.{
     <PREFIX_CONJUNCTION>conj1
     <RIGHT_LOGIC_ITEM>comma.<NEXT_COLLOCATION_ITEM>conj2.<NEXT_ADJECTIVE>a2
    }
}

// ---------------------

// Инфинитив в некоторых случаях может выступать в роли прямого дополнения:
// Собери поесть в дороге.
//        ^^^^^^^^^^^^^^^
pattern ГлОбъект
{
 inf=ИнфКакОбъект2Восх : export { ПАДЕЖ:ВИН node:root_node }
 @noshift(ПравыйОграничительОборота)
} : ngrams { -4 }

pattern ГлОбъект
{
 inf=ИнфКакОбъект2Восх : export { ПАДЕЖ:ВИН node:root_node }
} : ngrams { -8 }


// -----------------------------------------------------------------------

pattern ДатОбъект
{
 ГлОбъект{ ПАДЕЖ:ДАТ } : export { node:root_node }
}

// ------------------------------------

patterns ВинОбъект export { node:root_node }

pattern ВинОбъект
{
 ГлОбъект{ ПАДЕЖ:ВИН } : export { node:root_node }
}

// ------------------------------------

pattern ТворОбъект
{
 ГлОбъект{ ПАДЕЖ:ТВОР } : export { node:root_node }
}


// ------------------------------------

pattern РодОбъект
{
 ГлОбъект{ ПАДЕЖ:РОД } : export { node:root_node }
}
