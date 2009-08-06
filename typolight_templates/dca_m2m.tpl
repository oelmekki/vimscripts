
                'CARBON' => array
                (
                        'label'                   => &$GLOBALS['TL_LANG']['TABLE_NAME']['CARBON'],
                        'exclude'                 => true,
                        'inputType'               => 'manyToManyCheckbox',
                        'foreignKey'              => '',
                        'eval'                    => array('mandatory'=>true, 'thisModel' => '', 'thatModel' => '', 'multiple' => true),
                ),
