
// по умолчанию предпочитаем существительное в именительном падеже:
// "простой техники" - тут будет сущ. простой, 
pattern НеполнПредлож
{
 ГруппаСущ4{ падеж:им } : export { node:root_node }
}

// Для существительного есть важная эмпирика - предложный падеж без предлога
// обычно не употребляется.
pattern НеполнПредлож
{
 ГруппаСущ4{ падеж:род } : export { node:root_node }
} : ngrams { -1 }


// чаю, греющего душу
pattern НеполнПредлож
{
 ГруппаСущ4{ падеж:парт } : export { node:root_node }
} : ngrams { -1 }


pattern НеполнПредлож
{
 ГруппаСущ4{ падеж:твор } : export { node:root_node }
} : ngrams { -1 }


pattern НеполнПредлож
{
 ГруппаСущ4{ падеж:вин } : export { node:root_node }
} : ngrams { -1 }


pattern НеполнПредлож
{
 ГруппаСущ4{ падеж:дат } : export { node:root_node }
} : ngrams { -1 }


// - О  глупый  Петер,  сын угольщика! - воскликнул человечек
//   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
pattern НеполнПредлож
{
 частица:о{}
 ГруппаСущ4{ падеж:им одуш:одуш } : export { node:root_node }
} : ngrams { -2 }


// спасибо тебе за прогулку.

// тут надо добавить генерацию уведомления, если нарушено правило связываемости
patterns СущПредлСущ_Клоз export { node:root_node }
pattern СущПредлСущ_Клоз
{
 n1=СущСРодДоп{ падеж:им } : export { node:root_node }
 p=предлог:*{}
 n2=ГлДополнение{ =p:падеж }
} : links { n1.<PREPOS_ADJUNCT>p.<OBJECT>n2 }
  : ngrams { -1 } // так как не проверяем связываемость, то априори штрафуем


pattern НеполнПредлож
{
 СущПредлСущ_Клоз : export { node:root_node }
}




wordentry_set НаречиеВремени=наречие:{
 однажды
}

// Однажды в Китае и Америке
pattern НеполнПредлож
{
 НаречиеВремени : export { node:root_node }
 Предлог_В_НА
 ГруппаСущ4{ падеж:предл }
}



// ------------------------------------------------------

/*
// ???
patterns ПредлогПрилаг export { node:root_node }

// Для последнего.
pattern ПредлогПрилаг
{
 p=предлог:*{} : export { node:root_node }
 a=ГруппаПрил2{ =p:падеж }
} : links { p.<OBJECT>a }
pattern НеполнПредлож { ПредлогПрилаг : export { node:root_node } } : ngrams { -1 }
*/



pattern НеполнПредлож { ГруппаНареч2 : export { node:root_node } }
pattern НеполнПредлож { ГруппаСрНареч2 : export { node:root_node } }
pattern НеполнПредлож { ГруппаПрил2 : export { node:root_node } }
pattern НеполнПредлож { КраткПрил1 : export { node:root_node } }
pattern НеполнПредлож { Обст : export { node:root_node } }
pattern НеполнПредлож { ПричОборот2 : export { node:root_node } }
pattern НеполнПредлож { ГруппаМест : export { node:root_node } }


pattern НеполнПредлож { Инф2 : export { node:root_node } }

// вот бы купить самолет!
pattern НеполнПредлож
{
 intro=ВводнаяФраза
 p=Инф2 : export { node:root_node }
} : links { p.<BEG_INTRO>intro }
  : ngrams { -1 }




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




pattern НеполнПредлож { Деепр2 : export { node:root_node } }

pattern НеполнПредлож { ЧислСущ : export { node:root_node } }

pattern НеполнПредлож
{
 v=Сказуемое : export { node:root_node }
}/*
: ngrams
{
 @tree_score(v,ВалентностьГлагола)
}*/


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

// Сказуемое с вводной конструкцией в роли неполного предложения:
// В соответствии с шариатом, свинину употреблять запрещено
pattern НеполнПредлож
{
 intro=ВводнаяФраза
 p=Сказуемое : export { node:root_node }
} : links { p.<BEG_INTRO>intro }



// Союз ЗАТО и другие как вводная частица:
// зато хорошенько изучил местность.
pattern НеполнПредлож
{
 conj=союз:*{}
 p=Сказуемое : export { node:root_node }
} : links { p.<BEG_INTRO>conj }

pattern НеполнПредлож { ПредлогИСущ : export { node:root_node } }


// был рад помочь
pattern НеполнПредлож
{
 НеполнСвязка : export { node:root_node }
}

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

