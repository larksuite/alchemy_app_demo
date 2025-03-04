/*
 * Copyright (c) 2025 Lark Technologies Pte. Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 *
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

package com.sample.android.alchemy.tab.container.mail

import android.os.Bundle
import android.view.View
import com.sample.android.alchemy.common.ui.utils.NotAvailableToast
import com.sample.android.alchemy.common.ui.base.BaseBindingFragment
import com.sample.android.alchemy.tab.container.R
import com.sample.android.alchemy.tab.container.databinding.AlchemySampleFragmentMailBinding
import com.sample.android.alchemy.tab.container.mail.bean.MailBean

/**
 * 主页面。
 */
class MainFragment :
    BaseBindingFragment<AlchemySampleFragmentMailBinding>(AlchemySampleFragmentMailBinding::inflate) {

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)

        childFragmentManager
            .beginTransaction()
            .add(R.id.container, MailListFragment { _, item ->
                navToMailDetailActivity(item)
            })
            .commitNow()

        initTitleView()
        initDrawer()
    }

    private fun navToMailDetailActivity(mailBean: MailBean) {
        MailDetailActivity.launch(requireContext(), mailBean.title, mailBean.content)
    }

    private fun initDrawer() {
        binding.drawer.let {
            it.inboxFrame.setOnClickListener(drawerItemNoopOnClickListener)
            it.flaggedFrame.setOnClickListener(drawerItemNoopOnClickListener)
            it.draftsFrame.setOnClickListener(drawerItemNoopOnClickListener)
            it.sentFrame.setOnClickListener(drawerItemNoopOnClickListener)
            it.trashFrame.setOnClickListener(drawerItemNoopOnClickListener)
            it.spamFrame.setOnClickListener(drawerItemNoopOnClickListener)
            it.composeFrame.setOnClickListener(drawerItemNoopOnClickListener)
        }
    }

    private val drawerItemNoopOnClickListener = View.OnClickListener {
        NotAvailableToast.show(requireContext())
        binding.drawerLayout.close()
    }

    private fun initTitleView() {
        binding.menuFrame.let {
            it.setOnClickListener {
                if (binding.drawerLayout.isOpen) {
                    binding.drawerLayout.close()
                } else {
                    binding.drawerLayout.open()
                }
            }
        }
        binding.titleEdit.let {
            it.setOnClickListener {
                NotAvailableToast.show(requireContext())
            }
        }
    }
}