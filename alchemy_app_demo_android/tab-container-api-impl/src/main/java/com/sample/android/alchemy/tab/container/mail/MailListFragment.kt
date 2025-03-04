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
import androidx.recyclerview.widget.LinearLayoutManager
import com.sample.android.alchemy.common.ui.base.BaseBindingFragment
import com.sample.android.alchemy.tab.container.databinding.AlchemySampleFragmentMailListBinding
import com.sample.android.alchemy.tab.container.mail.adapter.MailAdapter
import com.sample.android.alchemy.tab.container.mail.bean.MockData
import com.sample.android.alchemy.common.ui.utils.NotAvailableToast

/**
 * 邮件列表页。
 */
class MailListFragment(private val onMailItemClickListener: MailAdapter.OnMailItemClickListener) :
    BaseBindingFragment<AlchemySampleFragmentMailListBinding>(
        AlchemySampleFragmentMailListBinding::inflate
    ) {
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        initRecyclerView()
        initFab()
    }

    private fun initRecyclerView() {
        binding.alchemySampleRecyclerView.let {
            it.layoutManager =
                LinearLayoutManager(requireContext(), LinearLayoutManager.VERTICAL, false)
            val mailAdapter = MailAdapter(requireContext(), onMailItemClickListener)
            it.adapter = mailAdapter
            mailAdapter.submitList(MockData.dataList)
        }
    }

    private fun initFab() {
        binding.createMail.setOnClickListener {
            NotAvailableToast.show(requireContext())
        }
    }
}