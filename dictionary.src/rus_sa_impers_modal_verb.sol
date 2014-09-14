
// МОДАЛЬНЫЕ КОНСТРУКЦИИ С БЕЗЛИЧНЫМ ГЛАГОЛОМ (ПРЕДИКАТИВОМ),
// в них инфинитив делаем корнем, чтобы разбирать непроективные конструкции
// с ребрами над предикативом.

patterns ГлБезличИнфВосх { bottomup  }
 export { node:root_node ТИП_ПРЕДИКАТИВ ПЕРЕХОДНОСТЬ ПАДЕЖ AUX_VERB_REQUIRED THEMA_VALENCY }

pattern ГлБезличИнфВосх export { node:root_node (ТИП_ПРЕДИКАТИВ) ПЕРЕХОДНОСТЬ ПАДЕЖ AUX_VERB_REQUIRED THEMA_VALENCY }
{
 Инф2БезДоп : export {
                      node:root_node
                      THEMA_VALENCY:1
                      ПЕРЕХОДНОСТЬ
                      ПАДЕЖ
                      AUX_VERB_REQUIRED:1
                     }
}

// Надо оформлять пропуска в закрытую зону, изучать анкеты
//      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
pattern ГлБезличИнфВосх export { node:root_node (ТИП_ПРЕДИКАТИВ) ПЕРЕХОДНОСТЬ (ПАДЕЖ) AUX_VERB_REQUIRED THEMA_VALENCY }
{
 Инф2 : export {
                node:root_node
                THEMA_VALENCY:1
                ПЕРЕХОДНОСТЬ:НЕПЕРЕХОДНЫЙ
                AUX_VERB_REQUIRED:1
               }
}


// мне открывать новую коробку неохота
pattern ГлБезличИнфВосх export { node:root_node ТИП_ПРЕДИКАТИВ AUX_VERB_REQUIRED ПЕРЕХОДНОСТЬ ПАДЕЖ THEMA_VALENCY }
{
 v=ГлБезличИнфВосх{ THEMA_VALENCY:1 } : export { node:root_node ТИП_ПРЕДИКАТИВ AUX_VERB_REQUIRED ПЕРЕХОДНОСТЬ ПАДЕЖ THEMA_VALENCY:0 }
 sbj=БезличПодлежащее{ ПАДЕЖ:ДАТ }
} 
: links { v.<SUBJECT>sbj }
: ngrams
{
 sbj_v_score(sbj,v)
 -2
}



pattern ГлБезличИнфВосх
{
 v=ГлБезличИнфВосх{AUX_VERB_REQUIRED:1} : export { node:root_node ПЕРЕХОДНОСТЬ ПАДЕЖ AUX_VERB_REQUIRED:0 THEMA_VALENCY }
 aux=БезличГлаг{ МОДАЛЬНЫЙ } : export { ТИП_ПРЕДИКАТИВ }
} : links { v.<LEFT_AUX_VERB>aux }


// Порой мне случается видеть будущее.
pattern ГлБезличИнфВосх
{
 v=ГлБезличИнфВосх{AUX_VERB_REQUIRED:1} : export { node:root_node ПЕРЕХОДНОСТЬ ПАДЕЖ AUX_VERB_REQUIRED:0 THEMA_VALENCY }
 aux=БезличГлаг{ ~МОДАЛЬНЫЙ } : export { ТИП_ПРЕДИКАТИВ }
}
: links { v.<LEFT_AUX_VERB>aux }
: ngrams { -5 }

// Мне жаль стало бросать начатую упаковку
//          ^^^^^
pattern ГлБезличИнфВосх
{
 v=ГлБезличИнфВосх{/*ТИП_ПРЕДИКАТИВ:БЫЛО_СВЯЗКА*/} : export { node:root_node ТИП_ПРЕДИКАТИВ ПЕРЕХОДНОСТЬ ПАДЕЖ AUX_VERB_REQUIRED THEMA_VALENCY }
 aux=БезличСвязка
} : links { v.<LEFT_AUX_VERB>aux }


// Оставлять неохота полную упаковку
//                   ^^^^^^^^^^^^^^^
pattern ГлБезличИнфВосх
{
 v=ГлБезличИнфВосх{ ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ } : export { node:root_node ТИП_ПРЕДИКАТИВ AUX_VERB_REQUIRED THEMA_VALENCY }
 obj=ГлДополнение{ =v:ПАДЕЖ } : export {
                                        @except(v:ПАДЕЖ,ПАДЕЖ)
                                        @if_exported(ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ,ПАДЕЖ)
                                       }
}
: links { v.<OBJECT>obj }
: ngrams { v_obj_score(v,obj) }


pattern ГлБезличИнфВосх
{
 v=ГлБезличИнфВосх : export { node:root_node ТИП_ПРЕДИКАТИВ ПЕРЕХОДНОСТЬ ПАДЕЖ AUX_VERB_REQUIRED THEMA_VALENCY }
 adv=Обст
}
: links { v.<ATTRIBUTE>adv }
: ngrams { adv_verb_score( adv, v ) }


pattern ГлБезличИнфВосх
{
 v=ГлБезличИнфВосх : export { node:root_node ТИП_ПРЕДИКАТИВ ПЕРЕХОДНОСТЬ ПАДЕЖ AUX_VERB_REQUIRED THEMA_VALENCY }
 attr=ОбособленныйАтрибут
} : links { v.<SEPARATE_ATTR>attr }


pattern ГлБезличИнфВосх
{
 v=ГлБезличИнфВосх : export { node:root_node ТИП_ПРЕДИКАТИВ ПЕРЕХОДНОСТЬ ПАДЕЖ AUX_VERB_REQUIRED THEMA_VALENCY }
 attr=ВводнАктант
} : links { v.<BEG_INTRO>attr }

pattern ГлБезличИнфВосх
{
 v=ГлБезличИнфВосх : export { node:root_node ТИП_ПРЕДИКАТИВ ПЕРЕХОДНОСТЬ ПАДЕЖ AUX_VERB_REQUIRED THEMA_VALENCY }
 attr=Детализатор
} : links { v.<DETAILS>attr }


pattern ГлБезличИнфВосх
{
 v=ГлБезличИнфВосх : export { node:root_node ТИП_ПРЕДИКАТИВ ПЕРЕХОДНОСТЬ ПАДЕЖ AUX_VERB_REQUIRED THEMA_VALENCY }
 x=ПрямоеОбращение
} : links { v.<APPEAL>x }


pattern ГлБезличИнфВосх
{
 v=ГлБезличИнфВосх : export { node:root_node ТИП_ПРЕДИКАТИВ ПЕРЕХОДНОСТЬ ПАДЕЖ AUX_VERB_REQUIRED THEMA_VALENCY }
 pn=ПредлогИСущ{ гл_предл( v, _.prepos, _.n2 ) }
}
: links { v.<PREPOS_ADJUNCT>pn }
: ngrams
{
 prepos_score( v, pn.prepos )
 ngram3( v, pn.prepos, pn.n2 )
}



// --------------------------------------------------------

patterns ГлБезличИнфНисх export { node:root_node ТИП_ПРЕДИКАТИВ ПЕРЕХОДНОСТЬ ПАДЕЖ AUX_VERB_REQUIRED THEMA_VALENCY }

pattern ГлБезличИнфНисх
{
 ГлБезличИнфВосх : export { node:root_node ТИП_ПРЕДИКАТИВ ПЕРЕХОДНОСТЬ ПАДЕЖ AUX_VERB_REQUIRED THEMA_VALENCY }
}

pattern ГлБезличИнфНисх
{
 sbj=БезличПодлежащее{ ПАДЕЖ:ДАТ }
 v=ГлБезличИнфНисх{ THEMA_VALENCY:1 } : export { node:root_node ТИП_ПРЕДИКАТИВ ПЕРЕХОДНОСТЬ ПАДЕЖ AUX_VERB_REQUIRED THEMA_VALENCY:0 }
}
: links { v.<SUBJECT>sbj }
: ngrams
{
 -2
 sbj_v_score(sbj,v)
}

// от этого мне было жаль отказываться
//              ^^^^
pattern ГлБезличИнфНисх
{
 aux=БезличСвязка
 v=ГлБезличИнфНисх{/*ТИП_ПРЕДИКАТИВ:БЫЛО_СВЯЗКА*/} : export { node:root_node ТИП_ПРЕДИКАТИВ ПЕРЕХОДНОСТЬ ПАДЕЖ AUX_VERB_REQUIRED THEMA_VALENCY }
} : links { v.<LEFT_AUX_VERB>aux }


pattern ГлБезличИнфНисх
{
 aux=БезличГлаг{ МОДАЛЬНЫЙ } : export { ТИП_ПРЕДИКАТИВ } 
 v=ГлБезличИнфНисх{ AUX_VERB_REQUIRED:1 } : export { node:root_node ПЕРЕХОДНОСТЬ ПАДЕЖ AUX_VERB_REQUIRED:0 THEMA_VALENCY }
} : links { v.<LEFT_AUX_VERB>aux }


// Отдельно рассматриваем триаду, итак как в этом случае
// подлежащее с большей вероятностью прикрепляется именно
// к безличному глаголу.
pattern ГлБезличИнфНисх
{
 sbj=БезличПодлежащее{ ПАДЕЖ:ДАТ }
 aux=БезличГлаг{ МОДАЛЬНЫЙ } : export { ТИП_ПРЕДИКАТИВ } 
 v=ГлБезличИнфНисх{ AUX_VERB_REQUIRED:1 THEMA_VALENCY:1 } : export { node:root_node ПЕРЕХОДНОСТЬ ПАДЕЖ AUX_VERB_REQUIRED:0 THEMA_VALENCY:0 }
}
 : links { v.{
              <LEFT_AUX_VERB>aux
              <SUBJECT>sbj
             }
         }



pattern ГлБезличИнфНисх
{
 adv=Обст
 v=ГлБезличИнфНисх : export { node:root_node ТИП_ПРЕДИКАТИВ ПЕРЕХОДНОСТЬ ПАДЕЖ AUX_VERB_REQUIRED THEMA_VALENCY }
}
: links { v.<ATTRIBUTE>adv }
: ngrams { adv_verb_score( adv, v ) }



patterns ЛевАтрибутСказуем export { node:root_node }

// Тебе что, приходится экономить?
pattern ГлБезличИнфНисх
{
 adv=ЛевАтрибутСказуем
 v=ГлБезличИнфНисх : export { node:root_node ТИП_ПРЕДИКАТИВ ПЕРЕХОДНОСТЬ ПАДЕЖ AUX_VERB_REQUIRED THEMA_VALENCY }
}
: links { v.<ATTRIBUTE>adv }
: ngrams { -2 }


pattern ГлБезличИнфНисх
{
 attr=ОбособленныйАтрибут
 v=ГлБезличИнфНисх : export { node:root_node ТИП_ПРЕДИКАТИВ ПЕРЕХОДНОСТЬ ПАДЕЖ AUX_VERB_REQUIRED THEMA_VALENCY }
} : links { v.<SEPARATE_ATTR>attr }

pattern ГлБезличИнфНисх
{
 attr=ВводнАктант
 v=ГлБезличИнфНисх : export { node:root_node ТИП_ПРЕДИКАТИВ ПЕРЕХОДНОСТЬ ПАДЕЖ AUX_VERB_REQUIRED THEMA_VALENCY }
} : links { v.<BEG_INTRO>attr }


pattern ГлБезличИнфНисх
{
 attr=Детализатор
 v=ГлБезличИнфНисх : export { node:root_node ТИП_ПРЕДИКАТИВ ПЕРЕХОДНОСТЬ ПАДЕЖ AUX_VERB_REQUIRED THEMA_VALENCY }
} : links { v.<DETAILS>attr }


pattern ГлБезличИнфНисх
{
 x=ПрямоеОбращение
 v=ГлБезличИнфНисх : export { node:root_node ТИП_ПРЕДИКАТИВ ПЕРЕХОДНОСТЬ ПАДЕЖ AUX_VERB_REQUIRED THEMA_VALENCY }
} : links { v.<APPEAL>x }

pattern ГлБезличИнфНисх
{
 pn=ПредлогИСущ
 v=ГлБезличИнфНисх{ гл_предл(_,pn.prepos,pn.n2) } : export { node:root_node ТИП_ПРЕДИКАТИВ ПЕРЕХОДНОСТЬ ПАДЕЖ AUX_VERB_REQUIRED THEMA_VALENCY }
}
: links { v.<PREPOS_ADJUNCT>pn }
: ngrams
{
 -1
 prepos_score( v, pn.prepos )
 ngram3( v, pn.prepos, pn.n2 )
}



pattern ГлБезличИнфНисх
{
 obj=ГлДополнение
 v=ГлБезличИнфНисх{ ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ =Obj:ПАДЕЖ }
     : export { 
               node:root_node
               AUX_VERB_REQUIRED
               ТИП_ПРЕДИКАТИВ
               THEMA_VALENCY
               @except(ПАДЕЖ,obj:ПАДЕЖ)
               @if_exported(ПЕРЕХОДНОСТЬ:ПЕРЕХОДНЫЙ,ПАДЕЖ)
              }
}
: links { v.<OBJECT>obj }
: ngrams
{
 -1
 v_obj_score( v, obj )
}

// -------------------------------------------

pattern ГлПредикат
{
 v=ГлБезличИнфНисх{ AUX_VERB_REQUIRED:0 } : export { node:root_node }
}
: ngrams
{
 ВалентностьПредиката(v)
 ВалентностьГлагола(v)
}

