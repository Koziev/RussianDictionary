
wordentry_set НетПредикативЧастица=частица:{ нет, нету }


patterns НетПредикатив export { node:root_node }
pattern НетПредикатив
{
 НетПредикативЧастица:export { node:root_node }
}

// нет же никакого смысла
// ^^^^^^
pattern НетПредикатив
{
 v=НетПредикативЧастица:export { node:root_node }
 p=частица:же{}
} : links { v.<POSTFIX_PARTICLE>p }

// нет ли другого способа?
// ^^^^^^
pattern НетПредикатив
{
 v=НетПредикативЧастица:export { node:root_node }
 p=частица:ли{}
} : links { v.<POSTFIX_PARTICLE>p }


// ++++++++++++

// У этого предприятия нет никакой будущности!
//                         ^^^^^^^^^^^^^^^^^^
pattern РодДополнение
{
 ГлДополнение{ ПАДЕЖ:РОД } : export { node:root_node ПАДЕЖ }
}

// проходу от них нету!
// ^^^^^^^
pattern РодДополнение
{
 ГлДополнение{ ПАДЕЖ:ПАРТ } : export { node:root_node ПАДЕЖ }
}

// ++++++++++++

patterns ОбособРодАтрибут export { node:root_node }


pattern ОбособРодАтрибут
{
 ГруппаПрил2{ ПАДЕЖ:РОД } : export { node:root_node }
}
: ngrams { -10 }


pattern ОбособРодАтрибут
{
 comma1=','
 a=ПричОборот2{ ПАДЕЖ:РОД } : export { node:root_node }
 @noshift(ПравыйОграничительОборота)
 comma2=@coalesce(',')
}
: links
{
 a.{
    <PUNCTUATION>comma1
    ~<PUNCTUATION>comma2
   }
}
: ngrams { -10 }


// ++++++++++++

patterns НетВосх { bottomup  } export { node:root_node ПЕРЕХОДНОСТЬ ПАДЕЖ }

pattern НетВосх
{
 НетПредикатив : export { node:root_node ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ ПАДЕЖ:РОД @add(ПАДЕЖ:ДАТ) }
}

pattern НетВосх
{
 v=НетВосх{ ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ ПАДЕЖ:РОД } : export { node:root_node }
 obj=РодДополнение : export {
                             @except(v:ПАДЕЖ,ПАДЕЖ)
                             @if_exported(ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ,ПАДЕЖ)
                            }
}
: links { v.<OBJECT>obj }
: ngrams { v_obj_score(v,obj) }


// Нету мне смысла стараться сильнее
pattern НетВосх
{
 v=НетВосх{ ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ ПАДЕЖ:ДАТ } : export { node:root_node }
 obj=ГлДополнение{ ПАДЕЖ:ДАТ } : export {
                                         @except(v:ПАДЕЖ,ПАДЕЖ)
                                         @if_exported(ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ,ПАДЕЖ)
                                        }
}
: links { v.<OBJECT>obj }
: ngrams { -5 }



pattern НетВосх
{
 v=НетВосх : export { node:root_node ПЕРЕХОДНОСТЬ ПАДЕЖ }
 adv=Обст
}
: links { v.<ATTRIBUTE>adv }
: ngrams { adv_verb_score( adv, v ) }


pattern НетВосх
{
 v=НетВосх : export { node:root_node ПЕРЕХОДНОСТЬ ПАДЕЖ }
 attr=ОбособРодАтрибут
} : links { v.<SEPARATE_ATTR>attr }


pattern НетВосх
{
 v=НетВосх : export { node:root_node ПЕРЕХОДНОСТЬ ПАДЕЖ }
 attr=ВводнАктант
} : links { v.<BEG_INTRO>attr }

pattern НетВосх
{
 v=НетВосх : export { node:root_node ПЕРЕХОДНОСТЬ ПАДЕЖ }
 attr=Детализатор
} : links { v.<DETAILS>attr }

pattern НетВосх
{
 v=НетВосх : export { node:root_node ПЕРЕХОДНОСТЬ ПАДЕЖ }
 x=ПрямоеОбращение
} : links { v.<APPEAL>x }

pattern НетВосх
{
 v=НетВосх : export { node:root_node ПЕРЕХОДНОСТЬ ПАДЕЖ }
 pn=ПредлогИСущ{ гл_предл( v, _.prepos, _.n2 ) }
}
: links { v.<PREPOS_ADJUNCT>pn }
: ngrams
{
 prepos_score( v, pn.prepos )
 ngram3( v, pn.prepos, pn.n2 )
}

// --------------------------------------------------------

patterns НетНисх export { node:root_node ПЕРЕХОДНОСТЬ ПАДЕЖ }

pattern НетНисх
{
 НетВосх : export { node:root_node ПЕРЕХОДНОСТЬ ПАДЕЖ }
}

// Мы весело играли
pattern НетНисх
{
 adv=Обст
 v=НетНисх : export { node:root_node ПЕРЕХОДНОСТЬ ПАДЕЖ }
} 
: links { v.<ATTRIBUTE>adv }
: ngrams { adv_verb_score( adv, v ) }



pattern НетНисх
{
 attr=ОбособРодАтрибут
 v=НетНисх : export { node:root_node ПЕРЕХОДНОСТЬ ПАДЕЖ }
} : links { v.<SEPARATE_ATTR>attr }

pattern НетНисх
{
 attr=ВводнАктант
 v=НетНисх : export { node:root_node ПЕРЕХОДНОСТЬ ПАДЕЖ }
} : links { v.<BEG_INTRO>attr }


pattern НетНисх
{
 attr=Детализатор
 v=НетНисх : export { node:root_node ПЕРЕХОДНОСТЬ ПАДЕЖ }
} : links { v.<DETAILS>attr }


pattern НетНисх
{
 x=ПрямоеОбращение
 v=НетНисх : export { node:root_node ПЕРЕХОДНОСТЬ ПАДЕЖ }
} 
: links { v.<APPEAL>x }

pattern НетНисх
{
 pn=ПредлогИСущ
 v=НетНисх { гл_предл(_,pn.prepos,pn.n2) } : export { node:root_node ПЕРЕХОДНОСТЬ ПАДЕЖ }
} 
: links { v.<PREPOS_ADJUNCT>pn }
: ngrams
{
 prepos_score( v, pn.prepos )
 ngram3( v, pn.prepos, pn.n2 )
}



pattern НетНисх
{
 obj=РодДополнение
 v=НетНисх { ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ ПАДЕЖ:РОД }
     : export { 
               node:root_node
               @except(ПАДЕЖ,obj:ПАДЕЖ)
               @if_exported(ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ,ПАДЕЖ)
              }
}
: links { v.<OBJECT>obj }
: ngrams { v_obj_score( v, obj ) }


// Мне нет смысла уходить
pattern НетНисх
{
 obj=ГлДополнение{ ПАДЕЖ:ДАТ }
 v=НетНисх { ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ ПАДЕЖ:ДАТ }
     : export { 
               node:root_node
               @except(ПАДЕЖ,obj:ПАДЕЖ)
               @if_exported(ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ,ПАДЕЖ)
              }
}
: links { v.<OBJECT>obj }
: ngrams { -5 }


// -------------------------------------------

pattern ГлПредикат
{
 v=НетНисх : export { node:root_node }
}
: ngrams
{
 ВалентностьПредиката(v)
}


// ------------------------------

// прыгать вниз нет смысла
pattern ГлПредикат
{
 inf=Инф2
 v=НетПредикатив:export { node:root_node }
 obj=ГруппаСущ1{ ПАДЕЖ:РОД МОДАЛЬНЫЙ }
} : links
{
 v.{
    <INFINITIVE>inf
    <OBJECT>obj
   }
}
: ngrams
{
 ВалентностьГлагола(v)
}

