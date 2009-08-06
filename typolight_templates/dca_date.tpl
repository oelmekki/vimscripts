
                'CARBON' => array
                (
                        'label'                   => &$GLOBALS['TL_LANG']['TABLE_NAME']['CARBON'],
                        'exclude'                 => true,
                        'inputType'               => 'text',
                        'eval'                    => array('rgxp'=>'date', 'datepicker'=>$this->getDatePickerString(), 'tl_class'=>'w50 wizard')

                ),
