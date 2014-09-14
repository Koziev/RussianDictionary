// -----------------------------------------------------------------------------
// File RUS_SA_FILTERS.SOL
//
// (c) Koziev Elijah
//
// Content:
// Синтаксический анализатор: правила для фильтрации изначально недопустимых
// вариаторов. 
//
// 30.12.2008 - добавлены проверки переходности и падежной валентности для
//              инфинитивов, глаголов, деепричастий
//
// 08.01.2009 - переделки в связи с выделением фазы фильтрации вариаторов на
//              этапе начальной генерации.
// 24.03.2009 - добавил правила для отсечения лишних проекций слова "ТО" в
//              конструкции "если ...., то", а также фильтр на предложный
//              падеж существительных.
// 08.06.2009 - добавлен фильтр для модальных безличных глаголов НАДО ПОЕСТЬ
// 30.03.2010 - добавлен фильтр для пары наречий УЖЕ СКОРО, чтобы отсеивать
//              сочетания сравнительной стапени первого наречия, кроме
//              служебных МЕНЕЕ и БОЛЕЕ.    
//
// Подробнее о правилах: http://www.solarix.ru/for_developers/docs/rules.shtml
// -----------------------------------------------------------------------------
//
// CD->24.09.2008
// LC->07.08.2012
// --------------

#include "aa_rules.inc"


// Сочетание предлога и прилагательного
// НА МЯГКОМ ДИВАНЕ
prefilter Filter_PrepAdj1 language=Russian
{
 if context { ПРЕДЛОГ:*{} ПРИЛАГАТЕЛЬНОЕ:*{ СТЕПЕНЬ:АТРИБ } }
  then
   {
    if context { W0=* *:* { =W0:ПАДЕЖ } }
     then 
      accept
     else if context { ПРЕДЛОГ:ЗА{} ПРИЛАГАТЕЛЬНОЕ:ОБА{ ПАДЕЖ:ВИН } } // за обе щёки
      then accept
     else if context { ПРЕДЛОГ:НА{} ПРИЛАГАТЕЛЬНОЕ:*{ ПАДЕЖ:ДАТ } } // для разбора исключения НА ДРУГОМ БЕРЕГУ
      then accept
     else 
      reject
   }
}


// Сочетание предлога и существительного
// НА ДИВАНЕ
prefilter Filter_PrepNoun1 language=Russian
{
 if context { ПРЕДЛОГ:*{} СУЩЕСТВИТЕЛЬНОЕ:*{} }
  then
   { 
    if context { W0=* *:* { =W0:ПАДЕЖ } }
     then accept
    else if context { ПРЕДЛОГ:ЗА{} СУЩЕСТВИТЕЛЬНОЕ:* { ПАДЕЖ:ИМ } } // Что за причина вставать так рано?
     then accept
//    else if context { ПРЕДЛОГ:*{} СУЩЕСТВИТЕЛЬНОЕ:БЕРЕГ { ПАДЕЖ:ДАТ } }
//     then accept
    else  
     reject
   }
}



prefilter Filter_PrepPronoun1 language=Russian
{
 // для меня
 if context { ПРЕДЛОГ:*{} МЕСТОИМЕНИЕ:*{} }
  then
   {
    if context { ПРЕДЛОГ:С{} * }
     then
      {
       if context { * МЕСТОИМЕНИЕ:*{ ПАДЕЖ:РОД } } // с тебя
        then accept 
       else if context { * МЕСТОИМЕНИЕ:*{ ПАДЕЖ:ТВОР } } // с тобой
        then accept 
        else reject
      }
     else if context { P=* *:*{ =P:ПАДЕЖ } }
     then 
      accept
     else
      reject
   }
}


// Опять надо повторять одно и то же
prefilter Filter_RejectPrepInf language=Russian
{
 if context { ПРЕДЛОГ Инфинитив }
  then reject
}


// Частица ЖЕ не может идти после предлога:
// Надо же под ноги смотреть!
// ^^^^^^^
prefilter Filter_PrepParticle1 language=Russian
{
 if context { ПРЕДЛОГ ЧАСТИЦА:ЖЕ{} }
  then reject
}   

prefilter Filter_PrepParticle2 language=Russian
{
 if context { ПРЕДЛОГ ЧАСТИЦА:ЛИ{} }
  then reject
}   



// ***********************************
// Два предлога не могут идти подряд 
// В ПЕРЕД
// ***********************************
prefilter Filter_RejectPrepPrep language=Russian
{
 if context { ПРЕДЛОГ ПРЕДЛОГ }
  then reject
}



prefilter Filter_RejectPrepVerb language=Russian
{
 if context { ПРЕДЛОГ Глагол }
  then reject
}


prefilter Filter_RejectPrepDeepr language=Russian
{
 if context { ПРЕДЛОГ Деепричастие }
  then reject
}



prefilter Filter_DeeprDeepr2 language=Russian
{
 // не находя покоя
 // купив слив
 if context { Деепричастие:*{} Деепричастие }
  then reject
}  





// ***********************************************************
// Для подряд идущих инфинитивов один должен быть модальным
// ***********************************************************
prefilter Filter_Modal2 language=Russian
{
 // НАЧАТЬ ДЕЛАТЬ
 // ДЕЛАТЬ НАЧАТЬ
 if context { Инфинитив Инфинитив }
  then
   { 
    if context { Инфинитив:*{ МОДАЛЬНЫЙ } Инфинитив }
     then accept
    else if context { Инфинитив Инфинитив:*{ МОДАЛЬНЫЙ } }
     then accept
    else
     reject  
   }
}



prefilter Filter_Modal3 language=Russian
{
 // НАЧИНАЯ ПЛЯСАТЬ
 if context { Деепричастие Инфинитив }
  then
   { 
    if context { *:*{ МОДАЛЬНЫЙ } * }
     then accept
     else reject
   }
 }
 



// ***********************************************************
// Инфинитив после причастия - только если оно модальное
// ***********************************************************
prefilter Filter_Modal4 language=Russian
{
 // НАЧИНАЮЩИЙ ПЛЯСАТЬ
 if context { Прилагательное:* { Причастие }  Инфинитив }
  then
   { 
    if context { Прилагательное:*{ МОДАЛЬНЫЙ } Инфинитив }
     then accept
     else reject
   }
 }

 
prefilter Filter_Modal5 language=Russian
{
 // НАЧИНАЮЩИЙ ПЛЯСАТЬ
 if context { БЕЗЛИЧ_ГЛАГОЛ  Инфинитив }
  then
   { 
    if context { БЕЗЛИЧ_ГЛАГОЛ:*{ МОДАЛЬНЫЙ } Инфинитив }
     then accept
     else reject
   }
 }

// не может идти подряд 2 безличных глагола, за исключением некоторых типа ЖАЛКО после СТАЛО или СТАНЕТ:
// лень надо перебарывать
prefilter Filter_Impersonate2 language=Russian
{
 if context { БЕЗЛИЧ_ГЛАГОЛ  БЕЗЛИЧ_ГЛАГОЛ }
  then
  {
   if context { безлич_глагол:стало{} * }
    then accept
    else reject
  }
}
 
 
 



prefilter Filter_AdjAdv2 language=Russian
{
 if context { ПРИЛАГАТЕЛЬНОЕ:*{ СТЕПЕНЬ:СРАВН } Наречие:*{ СТЕПЕНЬ:АТРИБ } }
  then reject    
}




// Звательный падеж не может идти сразу после глаголов, существительных и т.д.
prefilter Filter_Vocative2 language=Russian
{
 if context { * СУЩЕСТВИТЕЛЬНОЕ:* { ПАДЕЖ:ЗВАТ } }
  then
  {
   if context { ИНФИНИТИВ * }
    then reject
   else if context { ГЛАГОЛ * }
    then reject
   else if context { НАРЕЧИЕ * }
    then reject
   else if context { ПРЕДЛОГ * }
    then reject
   else if context { ПРИЛАГАТЕЛЬНОЕ * }
    then reject
   else if context { СУЩЕСТВИТЕЛЬНОЕ * }
    then reject
   else if context { МЕСТОИМЕНИЕ * }
    then reject
   else if context { МЕСТОИМ_СУЩ * }
    then reject
  }
}



// *******************************************************
// не может идти подряд 2 глагола в одинаковом времени
// поджег запал
// образовался смог
// купил мел
// *******************************************************
prefilter Filter_SameTenseVerb2 language=Russian
{
 if context { V1=глагол:*{ наклонение:изъяв } глагол:*{ наклонение:изъяв =V1:время } }
  then reject
}   



// ***********************************************************************
// после глагола в изъявительном наклонении не может идти побудительное:
// ***********************************************************************
// вижу три
// видел три
// увидишь три
prefilter Filter_SameTenseVerb4 language=Russian
{
 if context { глагол:*{ наклонение:изъяв } глагол:*{ наклонение:побуд } }
  then reject
}   


// *********************************************
// не может подряд идти 2 звательных падежа
// КОЛЬ ПЕТЬ НЕЛЬЗЯ
// *********************************************
prefilter Filter_DoubleVocative language=Russian
{
 if context { существительное:*{ падеж:зват } существительное:*{ падеж:зват } }
  then reject
}







// НАДО ТОРТ (КУПИТЬ)
// НАДО БЫЛО ТОРТ (КУПИТЬ)
// НАДО БУДЕТ ТОРТ (КУПИТЬ)
prefilter Filter_Impersonate3 language=Russian
{
 if context { безлич_глагол существительное:*{ падеж:им } }
  then reject
}   




// НАДО ВКУСНЫЙ (ТОРТ КУПИТЬ) 
prefilter Filter_Impersonate6 language=Russian
{
 if context { безлич_глагол прилагательное:*{ падеж:им } }
  then reject
}





