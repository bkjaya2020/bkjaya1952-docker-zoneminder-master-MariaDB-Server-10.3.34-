<?php
//
// ZoneMinder web logout view file, $Date$, $Revision$
// Copyright (C) 2001-2008 Philip Coombes
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
//
global $CLANG;
?>
<div id="modalLogout" class="modal" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title"><?php echo validHtmlStr(ZM_WEB_TITLE) . ' ' . translate('Logout') ?></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p><?php echo sprintf( $CLANG['CurrentLogin'], $user['Username'] ) ?></p>
      </div>
      <div class="modal-footer">
                <form name="logoutForm" id="logoutForm" method="post" action="?">
          <input type="hidden" name="view" value="logout"/>
          <button type="submit" name="action" value="logout"><?php echo translate('Logout') ?></button>
          <?php if ( ZM_USER_SELF_EDIT ) echo '<button type="submit" name="action" value="config">'.translate('Config').'</button>'.PHP_EOL; ?>
          <button type="button" data-dismiss="modal"><?php echo translate('Cancel') ?></button>
        </form>
      </div>
    </div>
  </div>
</div>
