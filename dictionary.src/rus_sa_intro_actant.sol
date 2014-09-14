// +++++++++++++++++++++++++++++++++++++++++++

// Считаем вводные словосочетания таким же компонентом предиката, как
// подлежащее или обстоятельство.


pattern МодальнСловосочет
{
 МодальСловосочет0 : export { node:root_node }
}

patterns ВводнАктант export { node:root_node }


pattern ВводнАктант
{
 comma1=','
 z=МодальнСловосочет : export { node:root_node }
 @noshift(ПравыйОграничительОборота)
 comma2=@coalesce(',')
}
: links
{
 z.{
    <PUNCTUATION>comma1
    ~<PUNCTUATION>comma2
   }
}
: ngrams { -5 }

// Ты просто... не совсем обычный.
//          ^^^
pattern ВводнАктант
{
 '...' : export { node:root_node }
} : ngrams { -5 }


// Плавать не умею, боюсь - и все тут.
//                        ^^^^^^^^^^^
pattern ВводнАктант
{
 t='-' : export { node:root_node }
 w1=союз:и{}
 w2=местоим_сущ:все{}
 w3=наречие:тут{}
 @noshift(ПравыйОграничительОборота)
}
: links
{
 t.<NEXT_COLLOCATION_ITEM>w1.<NEXT_COLLOCATION_ITEM>w2.<NEXT_COLLOCATION_ITEM>w3
}
: ngrams { -5 }

