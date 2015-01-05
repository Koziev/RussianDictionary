
// по умолчанию предпочитаем существительное в именительном падеже:
// "простой техники" - тут будет сущ. простой, 
pattern НеполнПредлож
{
 ГруппаСущ4{ падеж:им } : export { node:root_node }
} : ngrams { -2 }

// Для существительного есть важная эмпирика - предложный падеж без предлога
// обычно не употребляется.
pattern НеполнПредлож
{
 ГруппаСущ4{ падеж:род } : export { node:root_node }
} : ngrams { -3 }


// чаю, греющего душу
pattern НеполнПредлож
{
 ГруппаСущ4{ падеж:парт } : export { node:root_node }
} : ngrams { -3 }


pattern НеполнПредлож
{
 ГруппаСущ4{ падеж:твор } : export { node:root_node }
} : ngrams { -3 }


pattern НеполнПредлож
{
 ГруппаСущ4{ падеж:вин } : export { node:root_node }
} : ngrams { -3 }


pattern НеполнПредлож
{
 ГруппаСущ4{ падеж:дат } : export { node:root_node }
} : ngrams { -3 }


// - О  глупый  Петер,  сын угольщика! - воскликнул человечек
//   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
pattern НеполнПредлож
{
 частица:о{}
 ГруппаСущ4{ падеж:им одуш:одуш } : export { node:root_node }
} : ngrams { -3 }


// Однажды в Китае и Америке
pattern НеполнПредлож
{
 adv=ГруппаНареч2
 p=Предлог_В_НА : export { node:root_node }
 n=ГруппаСущ4{ падеж:предл }
}
: links { p.{ <ATTRIBUTE>adv <OBJECT>n } }
: ngrams { -4 }



// ------------------------------------------------------

pattern НеполнПредлож { ГруппаНареч2 : export { node:root_node } }
: ngrams { -4 }

pattern НеполнПредлож { ГруппаСрНареч2 : export { node:root_node } }
: ngrams { -4 }

pattern НеполнПредлож { ГруппаПрил2 : export { node:root_node } }
: ngrams { -3 }

pattern НеполнПредлож { КраткПрил1 : export { node:root_node } }
: ngrams { -3 }

pattern НеполнПредлож { Обст : export { node:root_node } }
: ngrams { -4 }

pattern НеполнПредлож { ПричОборот2 : export { node:root_node } }
: ngrams { -3 }

pattern НеполнПредлож { ГруппаМест : export { node:root_node } }
: ngrams { -4 }


pattern НеполнПредлож { Инф2 : export { node:root_node } }
: ngrams { -3 }


// - Приготовить чай, мамочка?
pattern НеполнПредлож
{
 v=Инф2 : export { node:root_node }
 x=ПрямоеОбращение
}
: links { v.<APPEAL>x }
: ngrams { -3 }

// Господа, немедленно покинуть помещение!
pattern НеполнПредлож
{
 x=ПрямоеОбращение
 v=Инф2 : export { node:root_node }
}
: links { v.<APPEAL>x }
: ngrams { -3 }


// вот бы купить самолет!
pattern НеполнПредлож
{
 intro=ВводнаяФраза
 p=Инф2 : export { node:root_node }
}
: links { p.<BEG_INTRO>intro }
: ngrams { -3 }


// - А по-моему, это очень нетрудно понять.
//   ^^^^^^^^^^
pattern НеполнПредлож
{
 intro0=ВводнСоюз
 intro=ВводнаяФраза
 p=Инф2 : export { node:root_node }
}
: links
{
 p.{
    <BEG_INTRO>intro0
    <BEG_INTRO>intro
   }
}
: ngrams { -3 }




// однако поступать так глупо
pattern НеполнПредлож
{
 opener=вводное:*{}
 s=Инф2 : export { node:root_node }
} : links { s.<BEG_INTRO>opener }
  : ngrams { -2 }

// или же держать при себе.
// И получше изучить местность.
// Ах, хорошо бы сейчас искупаться в Черном море!
pattern НеполнПредлож
{
 opener=СоюзКакВводн
 s=Инф2 : export { node:root_node }
} : links { s.<BEG_INTRO>opener }
: ngrams { -3 }

// - А если откачать воду из минных труб?
//   ^^^^^^
pattern НеполнПредлож
{
 opener0=СоюзКакВводн0
 opener=СоюзКакВводн
 s=Инф2 : export { node:root_node }
}
: links { s.{ <BEG_INTRO>opener0 <BEG_INTRO>opener } }
: ngrams { -3 }



// Да, но где же взять двенадцатый?
// ^^^^^^
pattern НеполнПредлож
{
 intro=ВводнаяФраза
 @probe_left(',')
 opener=СоюзКакВводн
 s=Инф2 : export { node:root_node }
}
: links
{
 s.{
    <BEG_INTRO>intro
    <BEG_INTRO>opener
   }
}
: ngrams { -3 }



pattern НеполнПредлож { Деепр2 : export { node:root_node } }
: ngrams { -4 }

pattern НеполнПредлож { ЧислСущ : export { node:root_node } }
: ngrams { -3 }


pattern НеполнПредлож
{
 v=Сказуемое : export { node:root_node }
}


// ЭТО в роли вводной частицы:
// это меня хотели убить!
pattern НеполнПредлож
{
 x=ЭтоКакЧастица
 p=Сказуемое : export { node:root_node }
} : links { p.<PREFIX_PARTICLE>x }
  : ngrams { -2 }


// ну хватит об этом
pattern НеполнПредлож
{
 x=частица:ну{}
 p=Сказуемое : export { node:root_node }
} : links { p.<BEG_INTRO>x }
  : ngrams { -2 }

/*
// Сказуемое с вводной конструкцией в роли неполного предложения:
// В соответствии с шариатом, свинину употреблять запрещено
pattern НеполнПредлож
{
 intro=ВводнаяФраза
 p=Сказуемое : export { node:root_node }
} : links { p.<BEG_INTRO>intro }
*/


// Союз ЗАТО и другие как вводная частица:
// зато хорошенько изучил местность.
pattern НеполнПредлож
{
 conj=союз:*{}
 p=Сказуемое : export { node:root_node }
}
: links { p.<BEG_INTRO>conj }
: ngrams { -2 }

pattern НеполнПредлож
{
 ПредлогИСущ : export { node:root_node }
}
: ngrams { -5 }


// был рад помочь
pattern НеполнПредлож
{
 НеполнСвязка : export { node:root_node }
}
: ngrams { -1 }

// ведь должны были сразу привести ее сюда.
pattern НеполнПредлож
{
 int=СоюзКакВводн0
 p=НеполнСвязка : export { node:root_node }
} : links
{
 p.<BEG_INTRO>int
}
: ngrams
{
 -1
}

