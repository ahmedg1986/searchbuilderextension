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