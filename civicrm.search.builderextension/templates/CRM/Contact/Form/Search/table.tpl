{*
 +--------------------------------------------------------------------+
 | CiviCRM version 4.7                                                |
 +--------------------------------------------------------------------+
 | Overriden core file template                                 |
 +--------------------------------------------------------------------+
*}

{* template for search builder *}
<div id="map-field">
{strip}
  {section start=1 name=blocks loop=$blockCount}
    {assign var="x" value=$smarty.section.blocks.index}
    <div class="crm-search-block">
      <h3>{if $x eq 1}{ts}Include contacts where{/ts}{else}{ts}Also include contacts where{/ts}{/if}</h3>
      <table>
        {section name=cols loop=$columnCount[$x]}
          {assign var="i" value=$smarty.section.cols.index}
          <tr>          
              <td class="form-item even-row">
              {$form.mapper[$x][$i].html}
              {$form.operator[$x][$i].html|crmAddClass:'required'}&nbsp;&nbsp;
             
              <span class="crm-search-value" id="crm_search_value_{$x}_{$i}" style="display:none">
                {$form.value[$x][$i].html|crmAddClass:'required'}
              </span>

              {* START - Extend CiviCRM search builder to support location based searches *}
              <span class="crm-search-postrange" id="crm_search_postrange_{$x}_{$i}" style="display:none">
                {$form.postal_code_low[$x][$i].html|crmAddClass:'required'} &nbsp; - &nbsp;
                {$form.postal_code_high[$x][$i].html|crmAddClass:'required'}
              </span>
              {* END - Extend CiviCRM search builder to support location based searches *}

              &nbsp
             
              {if $i gt 0 or $x gt 1}
                &nbsp;<a href="#" class="crm-reset-builder-row crm-hover-button" title="{ts}Remove this row{/ts}"><i class="crm-i fa-times"></i></a>
              {/if}
            </td>
          </tr>
        {/section}

        <tr class="crm-search-builder-add-row">
          <td class="form-item even-row underline-effect">
            {$form.addMore[$x].html}
          </td>
        </tr>
      </table>
    </div>
  {/section}
  <h3 class="crm-search-builder-add-block underline-effect">{$form.addBlock.html}</h3>
{/strip}
</div>

{* START - Extend CiviCRM search builder to support location based searches *}
<script type="text/javascript">
{literal}
            
  CRM.$(function($) {
    
    $('.crm-search-postrange').hide();
    
    $('#crm-main-content-wrapper').on('change', 'select[id^=mapper][id$="_1"], select[id^=operator]', handleUserInputPostCodeField)

    function handleUserInputPostCodeField() {
      var row = $(this).closest('tr');
      var field = $('select[id^=mapper][id$="_1"]', row).val();
      var operator = $('select[id^=operator]', row);
      var op = operator.val();          

      $("select[id^=operator] option[value='range']", row).hide();

      if (field == 'postal_code') {
        $("select[id^=operator] option[value='range']", row).show();
        if(field == 'postal_code' && op == 'range'){
          $('.crm-search-value', row).hide().find('input, select').val('');  
          $('.crm-search-postrange', row).show();
          return;
        } else{
          $('.crm-search-postrange', row).hide();
        }
      } else {
        $('.crm-search-postrange', row).hide();
      }
    }

    $(function($) {
        $('#crm-main-content-wrapper')
          // Reset and hide row
          .on('click', '.crm-reset-builder-row', function() {
            var row = $(this).closest('tr');
            $('input, select', row).val('').change();
            row.hide();
            // Hide entire block if this is the only visible row
            if (row.siblings(':visible').length < 2) {
              row.closest('.crm-search-block').hide();
            }
            return false;
          })
          
          // Handle field and operator selection
          .on('change', 'select[id^=mapper][id$="_1"], select[id^=operator]', handleUserInputPostCodeField)
          // Handle option selection - update hidden value field
          .on('change', '.crm-search-value select', function() {
            var value = $(this).val() || '';
            if ($(this).attr('multiple') == 'multiple' && value.length) {
              value = value.join(',');
            }
            $(this).siblings('input').val(value);
          })
          .on('crmLoad', function() {
            $('select[id^=mapper][id$="_1"]', '#Builder').each(handleUserInputPostCodeField);
          });
          // Fetch initial options during page refresh - it's more efficient to bundle them in a single ajax request
          var initialFields = {}, fetchFields = false;
          $('select[id^=mapper][id$="_1"] option:selected', '#Builder').each(function() {
            var field = $(this).attr('value');
            if (typeof(CRM.searchBuilder.fieldOptions[field]) == 'string') {
              initialFields[field] = [CRM.searchBuilder.fieldOptions[field], 'getoptions', {field: field, sequential: 1}];
              fetchFields = true;
            }
          });
          if (fetchFields) {
            CRM.api3(initialFields).done(function(data) {
              $.each(data, function(field, result) {
                CRM.searchBuilder.fieldOptions[field] = result.values;
              });
              $('select[id^=mapper][id$="_1"]', '#Builder').each(handleUserInputPostCodeField);
            });
          } else {
            $('select[id^=mapper][id$="_1"]', '#Builder').each(handleUserInputPostCodeField);
          }
    });

  });
{/literal}
</script>
{* END - Extend CiviCRM search builder to support location based searches *}
